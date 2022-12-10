package com.sail_tunnel.sail

import android.app.Service
import android.content.Intent
import android.net.*
import android.os.Build
import android.os.ParcelFileDescriptor
import com.sail_tunnel.sail.net.DefaultNetworkListener
import com.sail_tunnel.sail.net.DnsResolverCompat
import com.sail_tunnel.sail.services.VpnState
import com.sail_tunnel.sail.services.LocalDnsWorker
import com.sail_tunnel.sail.services.TunnelInstance
import com.sail_tunnel.sail.utils.readableMessage
import kotlinx.coroutines.*
import java.io.File
import java.io.IOException

class TunnelService : VpnService() {
    companion object {
        private const val CORE_NAME = "leaf"
        private const val VPN_MTU = 1500
        private const val PRIVATE_VLAN4_CLIENT = "192.168.20.2"
        private const val PRIVATE_VLAN4_ROUTER = "1.1.1.1"
    }

    inner class NullConnectionException : NullPointerException() {
        override fun getLocalizedMessage() =
            "Failed to start VPN service. You might need to reboot your device."
    }

    private val data = VpnState.Data()

    private fun startRunner() {
        if (Build.VERSION.SDK_INT >= 26) startForegroundService(Intent(this, javaClass))
        else startService(Intent(this, javaClass))
    }

    private var pfd: ParcelFileDescriptor? = null
    private var active = false
    private var metered = false

    @Volatile
    private var underlyingNetwork: Network? = null
        set(value) {
            field = value
            if (active) setUnderlyingNetworks(underlyingNetworks)
        }
    private val underlyingNetworks
        get() =
            // clearing underlyingNetworks makes Android 9 consider the network to be metered
            if (Build.VERSION.SDK_INT == 28 && metered) null else underlyingNetwork?.let {
                arrayOf(
                    it
                )
            }

    override fun onRevoke() = stopRunner()

    private fun killProcesses(scope: CoroutineScope) {
        data.proxy?.run {
            shutdown(scope)
            data.proxy = null
        }
        data.localDns?.shutdown(scope)
        data.localDns = null

        active = false
        scope.launch { DefaultNetworkListener.stop(this) }
        pfd?.close()
        pfd = null
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        val data = data
        if (data.state != VpnState.State.Stopped) return Service.START_NOT_STICKY

        try {
            data.proxy = TunnelInstance()
        } catch (e: IllegalArgumentException) {
            stopRunner(false, e.message)
            return Service.START_NOT_STICKY
        }

        data.changeState(VpnState.State.Connecting)
        data.connectingJob = GlobalScope.launch(Dispatchers.Main) {
            try {
                preInit()

                startVpn()

                data.changeState(VpnState.State.Connected)
            } catch (_: CancellationException) {
                // if the job was cancelled, it is canceller's responsibility to call stopRunner
            } catch (exc: Throwable) {
                stopRunner(false, exc.readableMessage)
            } finally {
                data.connectingJob = null
            }
        }

        return START_NOT_STICKY
    }

    private suspend fun preInit() = DefaultNetworkListener.start(this) { underlyingNetwork = it }
    private suspend fun rawResolver(query: ByteArray) =
    // no need to listen for network here as this is only used for forwarding local DNS queries.
        // retries should be attempted by client.
        DnsResolverCompat.resolveRaw(underlyingNetwork ?: throw IOException("no network"), query)

    private suspend fun startVpn() {
        val builder = Builder()
            .setConfigureIntent(Core.configureIntent(this))
            .setSession(CORE_NAME)
            .setMtu(VPN_MTU)
            .addAddress(PRIVATE_VLAN4_CLIENT, 24)
            .addDnsServer(PRIVATE_VLAN4_ROUTER)
            .addRoute("0.0.0.0", 0)

        active = true   // possible race condition here?
        builder.setUnderlyingNetworks(underlyingNetworks)
        if (Build.VERSION.SDK_INT >= 29) builder.setMetered(metered)

        this.pfd = builder.establish() ?: throw NullConnectionException()

        val context = Core.deviceStorage
        val configRoot = context.noBackupFilesDir

        data.localDns = LocalDnsWorker(this::rawResolver).apply { start() }

        val configFile = File(configRoot, VpnState.CONFIG_FILE)
        val configContent = configFile
            .readText()
            .replace("{{leafLogFile}}", File(configRoot, VpnState.LEAF_LOG_FILE).absolutePath)
            .replace("{{tunFd}}", this.pfd?.fd?.toLong().toString())

        configFile.writeText(configContent)

        data.proxy!!.start(
            this,
            File(Core.deviceStorage.noBackupFilesDir, "stat_main"),
            configFile,
        )
    }

    private fun stopRunner(restart: Boolean = false, msg: String? = null) {
        if (data.state == VpnState.State.Stopping) return
        // channge the state
        data.changeState(VpnState.State.Stopping)
        GlobalScope.launch(Dispatchers.Main.immediate) {
            data.connectingJob?.cancelAndJoin() // ensure stop connecting first
            // we use a coroutineScope here to allow clean-up in parallel
            coroutineScope {
                killProcesses(GlobalScope)
            }

            // change the state
            data.changeState(VpnState.State.Stopped, msg)

            // stop the service if nothing has bound to it
            if (restart) startRunner() else {
                stopSelf()
            }
        }
    }
}

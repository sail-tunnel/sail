package com.sail_tunnel.sail.services

import android.net.LocalServerSocket
import android.net.LocalSocket
import android.net.LocalSocketAddress
import android.system.Os
import com.sail_tunnel.sail.Core
import com.sail_tunnel.sail.TunnelService
import kotlinx.coroutines.CoroutineScope
import timber.log.Timber
import java.io.File
import java.nio.ByteBuffer
import kotlin.concurrent.thread

class TunnelInstance() {
    private var configFile: File? = null
    var trafficMonitor: TrafficMonitor? = null

    private val rtId: Int = 666

    init {
        System.loadLibrary("leaf")
    }

    private external fun leafRun(rtId: Int, configPath: String)
    private external fun leafReload(rtId: Int)
    private external fun leafShutdown(rtId: Int)
    private external fun leafTestConfig(configPath: String)

    /**
     * Sensitive shadowsocks configuration file requires extra protection. It may be stored in encrypted storage or
     * device storage, depending on which is currently available.
     */
    fun start(
        service: TunnelService,
        stat: File,
        configFile: File,
    ) {
        // setup traffic monitor path
        trafficMonitor = TrafficMonitor(stat)

        Timber.i("start process")

        val context = Core.deviceStorage
        val configRoot = context.noBackupFilesDir
        val protectPath =
            File.createTempFile("socket_protect", ".sock", configRoot).absolutePath

        Os.setenv("SOCKET_PROTECT_PATH", protectPath, true)

        println(protectPath)

        thread (start = true) {
            val localSocket = LocalSocket()
            localSocket.bind(
                LocalSocketAddress(
                    protectPath,
                    LocalSocketAddress.Namespace.FILESYSTEM
                )
            )
            val socket = LocalServerSocket(localSocket.fileDescriptor)
            val buffer = ByteBuffer.allocate(4)

            while (true) {
                val stream = socket.accept()
                buffer.clear()
                val n = stream.inputStream.read(buffer.array())

                System.out.write(n)

                if (n == 4) {
                    val fd = buffer.int
                    if (!service.protect(fd)) {
                        println("protect failed")
                    }
                    buffer.clear()
                    buffer.putInt(0)
                } else {
                    buffer.clear()
                    buffer.putInt(1)
                }
                stream.outputStream.write(buffer.array())
            }
        }

        // start tunnel program
        thread(start = true) {
            leafRun(rtId, configFile.absolutePath)
        }
    }

    fun shutdown(scope: CoroutineScope) {
        trafficMonitor?.apply {
            thread.shutdown(scope)
            persistStats()    // Make sure update total traffic when stopping the runner
        }
        trafficMonitor = null
        configFile?.delete()    // remove old config possibly in device storage
        configFile = null

        // stop tunnel program
        thread(start = true, isDaemon = true) {
            leafShutdown(rtId)
        }
    }
}

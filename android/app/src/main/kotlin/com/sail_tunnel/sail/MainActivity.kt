package com.sail_tunnel.sail

import android.content.Intent
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.net.VpnService
import android.os.Bundle
import com.sail_tunnel.sail.services.VpnState
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity: FlutterActivity() {
    private val channel = "com.sail_tunnel.sail/vpn_manager"

    private fun getServiceIntent(): Intent {
        return Intent(this, TunnelService::class.java)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Core.init(this, MainActivity::class)
    }

    private fun getVPNConnectionStatus(): Boolean? {
        val context = this@MainActivity
        val connectivityManager =
            context.getSystemService(CONNECTIVITY_SERVICE) as ConnectivityManager
        val activeNetwork = connectivityManager.activeNetwork
        val networkCapabilities = connectivityManager.getNetworkCapabilities(activeNetwork)

        return networkCapabilities?.hasTransport(NetworkCapabilities.TRANSPORT_VPN)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler {
            call, result ->
            // This method is invoked on the main thread.
            if (call.method == "getStatus") {
                result.success(getVPNConnectionStatus())
            } else if (call.method == "toggle") {
                val intent = VpnService.prepare(this)
                if (intent != null) {
                    startActivityForResult(intent, 0)
                    result.success(false)
                } else {
                    startService(getServiceIntent())
                    result.success(true)
                }
            } else if (call.method == "getTunnelLog") {
                val context = Core.deviceStorage
                val configRoot = context.noBackupFilesDir
                val config = File(configRoot, VpnState.LEAF_LOG_FILE).readText()

                result.success(config)
            } else if (call.method == "getTunnelConfiguration") {
                val context = Core.deviceStorage
                val configRoot = context.noBackupFilesDir
                val config = File(configRoot, VpnState.CONFIG_FILE).readText()

                result.success(config)
            } else if (call.method == "setTunnelConfiguration") {
                val context = Core.deviceStorage
                val configRoot = context.noBackupFilesDir

                File(configRoot, VpnState.CONFIG_FILE).writeText(call.arguments as String)
            } else if (call.method == "update") {
                //
            } else {
                result.notImplemented()
            }
        }
    }

    override fun onActivityResult(request: Int, result: Int, data: Intent?) {
        if (result == RESULT_OK) {
            startService(getServiceIntent())
        } else {
            super.onActivityResult(request, result, data)
        }
    }
}

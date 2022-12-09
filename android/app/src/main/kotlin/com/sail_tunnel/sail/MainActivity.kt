package com.sail_tunnel.sail

import android.content.Intent
import android.net.VpnService
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val channel = "com.sail_tunnel.sail/vpn_manager"

    private fun getServiceIntent(): Intent {
        return Intent(this, TunnelService::class.java)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler {
            call, result ->
            // This method is invoked on the main thread.
            if (call.method == "getStatus") {
                result.success(1)
            } else if (call.method == "toggle") {
                val intent: Intent = VpnService.prepare(this@MainActivity)
                startActivityForResult(intent, 0)
                result.success(true)
            } else if (call.method == "getTunnelLog") {
                //
            } else if (call.method == "getTunnelConfiguration") {
                result.success("")
            } else if (call.method == "setTunnelConfiguration") {
                //
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

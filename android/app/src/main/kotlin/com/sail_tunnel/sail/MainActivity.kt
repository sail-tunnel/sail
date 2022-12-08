package com.sail_tunnel.sail

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val channel = "com.sail_tunnel.sail/vpn_manager"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler {
            call, result ->
            // This method is invoked on the main thread.
            if (call.method == "getStatus") {
                result.notImplemented()
            } else if (call.method == "toggle") {
                result.notImplemented()
            } else if (call.method == "getTunnelLog") {
                result.notImplemented()
            } else if (call.method == "getTunnelConfiguration") {
                result.notImplemented()
            } else if (call.method == "setTunnelConfiguration") {
                result.notImplemented()
            } else if (call.method == "update") {
                result.notImplemented()
            } else {
                result.notImplemented()
            }
        }
    }
}

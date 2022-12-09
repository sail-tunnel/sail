package com.sail_tunnel.sail

import android.content.Intent
import android.net.LocalServerSocket
import android.net.LocalSocket
import android.net.LocalSocketAddress
import android.net.VpnService
import java.io.File
import java.io.FileOutputStream
import java.nio.ByteBuffer
import kotlin.concurrent.thread

class TunnelService : VpnService() {
    private lateinit var bgThread: Thread

    private val rtId: Int = 666

    init {
        System.loadLibrary("leaf")
    }

    private external fun leafRun(rdId: Int, configPath: String)
    private external fun leafReload(rdId: Int)
    private external fun leafShutdown(rdId: Int)
    private external fun leafTestConfig(configPath: String)

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        bgThread = thread(start = true) {
            val tunFd = Builder().setSession("leaf")
                .setMtu(1500)
                .addAddress("192.168.20.2", 30)
                .addDnsServer("1.1.1.1")
                .addRoute("0.0.0.0", 0).establish()
            val configFile = File(filesDir, "config  .conf")
            var configContent = """
            [General]
            loglevel = trace
            dns-server = 223.5.5.5
            tun-fd = REPLACE-ME-WITH-THE-FD
            [Proxy]
            Direct = direct
            """
            configContent =
                configContent.replace("REPLACE-ME-WITH-THE-FD", tunFd?.fd?.toLong().toString())
            println(configContent)
            FileOutputStream(configFile).use {
                it.write(configContent.toByteArray())
            }
            leafRun(rtId, configFile.absolutePath)
        }
        return START_NOT_STICKY
    }
}

package com.sail_tunnel.sail.services

import com.sail_tunnel.sail.TunnelService
import kotlinx.coroutines.CoroutineScope
import timber.log.Timber
import java.io.File
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

        // start tunnel program
        thread (start = true, isDaemon = true) {
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
    }
}

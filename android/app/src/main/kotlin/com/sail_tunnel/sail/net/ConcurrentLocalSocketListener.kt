package com.sail_tunnel.sail.net

import android.net.LocalSocket
import kotlinx.coroutines.*
import timber.log.Timber
import java.io.File

abstract class ConcurrentLocalSocketListener(name: String, socketFile: File) : LocalSocketListener(name, socketFile),
    CoroutineScope {
    override val coroutineContext = Dispatchers.IO + SupervisorJob() + CoroutineExceptionHandler { _, t -> Timber.w(t) }

    override fun accept(socket: LocalSocket) {
        launch { super.accept(socket) }
    }

    override fun shutdown(scope: CoroutineScope) {
        running = false
        cancel()
        super.shutdown(scope)
        coroutineContext[Job]!!.also { job -> scope.launch { job.join() } }
    }
}


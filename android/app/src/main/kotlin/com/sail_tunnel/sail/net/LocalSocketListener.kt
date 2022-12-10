package com.sail_tunnel.sail.net

import android.annotation.SuppressLint
import android.net.LocalServerSocket
import android.net.LocalSocket
import android.net.LocalSocketAddress
import android.system.ErrnoException
import android.system.Os
import android.system.OsConstants
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.channels.Channel
import kotlinx.coroutines.channels.onFailure
import kotlinx.coroutines.channels.trySendBlocking
import kotlinx.coroutines.launch
import timber.log.Timber
import java.io.File
import java.io.IOException

abstract class LocalSocketListener(name: String, socketFile: File) : Thread(name) {
    private val localSocket = LocalSocket().apply {
        socketFile.delete() // It's a must-have to close and reuse previous local socket.
        bind(LocalSocketAddress(socketFile.absolutePath, LocalSocketAddress.Namespace.FILESYSTEM))
    }
    private val serverSocket = LocalServerSocket(localSocket.fileDescriptor)
    private val closeChannel = Channel<Unit>(1)
    @Volatile
    protected var running = true

    /**
     * Inherited class do not need to close input/output streams as they will be closed automatically.
     */
    protected open fun accept(socket: LocalSocket) = socket.use { acceptInternal(socket) }
    protected abstract fun acceptInternal(socket: LocalSocket)
    final override fun run() {
        localSocket.use {
            while (running) {
                try {
                    accept(serverSocket.accept())
                } catch (e: IOException) {
                    if (running) Timber.w(e)
                    continue
                }
            }
        }
        closeChannel.trySendBlocking(Unit).onFailure { throw it!! }
    }

    @SuppressLint("NewApi")
    open fun shutdown(scope: CoroutineScope) {
        running = false
        localSocket.fileDescriptor?.apply {
            // see also: https://issuetracker.google.com/issues/36945762#comment15
            if (valid()) try {
                Os.shutdown(this, OsConstants.SHUT_RDWR)
            } catch (e: ErrnoException) {
                // suppress fd inactive or already closed
                if (e.errno != OsConstants.EBADF && e.errno != OsConstants.ENOTCONN) throw e.rethrowAsSocketException()
            }
        }
        scope.launch { closeChannel.receive() }
    }
}

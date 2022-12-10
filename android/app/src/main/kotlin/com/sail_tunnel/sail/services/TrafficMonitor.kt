package com.sail_tunnel.sail.services

import android.net.LocalSocket
import android.os.SystemClock
import com.sail_tunnel.sail.net.LocalSocketListener
import com.sail_tunnel.sail.utils.TrafficStats
import java.io.File
import java.io.IOException
import java.nio.ByteBuffer
import java.nio.ByteOrder

class TrafficMonitor(statFile: File) {
    val thread = object : LocalSocketListener("TrafficMonitor-" + statFile.name, statFile) {
        private val buffer = ByteArray(16)
        private val stat = ByteBuffer.wrap(buffer).order(ByteOrder.LITTLE_ENDIAN)
        override fun acceptInternal(socket: LocalSocket) {
            when (val read = socket.inputStream.read(buffer)) {
                -1 -> return
                16 -> { }
                else -> throw IOException("Unexpected traffic stat length $read")
            }
            val tx = stat.getLong(0)
            val rx = stat.getLong(8)
            if (current.txTotal != tx) {
                current.txTotal = tx
                dirty = true
            }
            if (current.rxTotal != rx) {
                current.rxTotal = rx
                dirty = true
            }
        }
    }.apply { start() }

    val current = TrafficStats()
    var out = TrafficStats()
    private var timestampLast = 0L
    private var dirty = false
    private var persisted: TrafficStats? = null

    fun requestUpdate(): Pair<TrafficStats, Boolean> {
        val now = SystemClock.elapsedRealtime()
        val delta = now - timestampLast
        timestampLast = now
        var updated = false
        if (delta != 0L) {
            if (dirty) {
                out = current.copy().apply {
                    txRate = (txTotal - out.txTotal) * 1024 / delta
                    rxRate = (rxTotal - out.rxTotal) * 1024 / delta
                }
                dirty = false
                updated = true
            } else {
                if (out.txRate != 0L) {
                    out.txRate = 0
                    updated = true
                }
                if (out.rxRate != 0L) {
                    out.rxRate = 0
                    updated = true
                }
            }
        }
        return Pair(out, updated)
    }

    fun persistStats() {
        val current = current
        check(persisted == null || persisted == current) { "Data loss occurred" }
        persisted = current

//        try {
//            // profile may have host, etc. modified and thus a re-fetch is necessary (possible race condition)
//            val profile = ProfileManager.getProfile(id) ?: return
//            profile.tx += current.txTotal
//            profile.rx += current.rxTotal
//            ProfileManager.updateProfile(profile)
//        } catch (e: IOException) {
//            if (!DataStore.directBootAware) throw e // we should only reach here because we're in direct boot
//            val profile = DirectBoot.getDeviceProfile()!!.toList().single { it.id == id }
//            profile.tx += current.txTotal
//            profile.rx += current.rxTotal
//            profile.dirty = true
//            DirectBoot.update(profile)
//            DirectBoot.listenForUnlock()
//        }
    }
}

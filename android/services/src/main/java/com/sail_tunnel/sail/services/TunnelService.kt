package com.sail_tunnel.sail.services

import android.content.Intent
import android.net.VpnService
import android.os.IBinder

class TunnelService : VpnService() {

    override fun onBind(intent: Intent): IBinder {
        TODO("Return the communication channel to the service.")
    }
}
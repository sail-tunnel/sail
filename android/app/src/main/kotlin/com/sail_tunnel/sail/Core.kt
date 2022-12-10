package com.sail_tunnel.sail

import android.app.*
import android.content.*
import android.net.ConnectivityManager
import android.util.Log
import androidx.annotation.VisibleForTesting
import androidx.core.content.getSystemService
import kotlinx.coroutines.DEBUG_PROPERTY_NAME
import kotlinx.coroutines.DEBUG_PROPERTY_VALUE_ON
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import timber.log.Timber
import kotlin.reflect.KClass
import androidx.work.Configuration
import com.sail_tunnel.sail.utils.DeviceStorageApp

object Core : Configuration.Provider {
    lateinit var app: MainActivity
        @VisibleForTesting set
    lateinit var configureIntent: (Context) -> PendingIntent
    val activity by lazy { app.getSystemService<ActivityManager>()!! }
    val connectivity by lazy { app.getSystemService<ConnectivityManager>()!! }

    val deviceStorage by lazy { DeviceStorageApp(app) }

    fun init(app: MainActivity, configureClass: KClass<out Any>) {
        this.app = app
        this.configureIntent = {
            PendingIntent.getActivity(it, 0, Intent(it, configureClass.java)
                .setFlags(Intent.FLAG_ACTIVITY_REORDER_TO_FRONT), PendingIntent.FLAG_IMMUTABLE)
        }

        // overhead of debug mode is minimal: https://github.com/Kotlin/kotlinx.coroutines/blob/f528898/docs/debugging.md#debug-mode
        System.setProperty(DEBUG_PROPERTY_NAME, DEBUG_PROPERTY_VALUE_ON)

        Timber.plant(object : Timber.DebugTree() {
            override fun log(priority: Int, tag: String?, message: String, t: Throwable?) {
                if (t == null) {
                    if (priority != Log.DEBUG || BuildConfig.DEBUG) Log.println(priority, tag, message)
                } else {
                    if (priority >= Log.WARN || priority == Log.DEBUG) Log.println(priority, tag, message)
                }
            }
        })
    }

    override fun getWorkManagerConfiguration() = Configuration.Builder().apply {
        setDefaultProcessName(app.packageName + ":bg")
        setMinimumLoggingLevel(if (BuildConfig.DEBUG) Log.VERBOSE else Log.INFO)
        setExecutor { GlobalScope.launch { it.run() } }
        setTaskExecutor { GlobalScope.launch { it.run() } }
    }.build()
}

package com.sharvayainfotech.eofficedesk

import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry


class Application : FlutterApplication(),PluginRegistry.PluginRegistrantCallback {
    override fun onCreate() {
        super.onCreate()

    }
    override fun registerWith(registry: PluginRegistry?) {
        if (registry != null) {
            FlutterLocalNotificationPluginRegistrant.registerWith(registry)
        }
    }

}
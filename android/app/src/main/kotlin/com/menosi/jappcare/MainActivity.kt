package com.menosi.jappcare

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel

class MainActivity : FlutterActivity() {

    companion object {
        private const val DEEP_LINK_CHANNEL = "com.jappcare/deep_link"
    }

    private var deepLinkEventSink: EventChannel.EventSink? = null
    private var pendingDeepLink: String? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Check if the activity was launched with a deep link intent
        intent?.data?.toString()?.let { uri ->
            if (uri.startsWith("jappcare://")) {
                pendingDeepLink = uri
            }
        }

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, DEEP_LINK_CHANNEL)
            .setStreamHandler(object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    deepLinkEventSink = events
                    // Flush any deep link that arrived before the stream was ready
                    pendingDeepLink?.let {
                        events?.success(it)
                        pendingDeepLink = null
                    }
                }

                override fun onCancel(arguments: Any?) {
                    deepLinkEventSink = null
                }
            })
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        intent.data?.toString()?.let { uri ->
            if (uri.startsWith("jappcare://")) {
                val sink = deepLinkEventSink
                if (sink != null) {
                    sink.success(uri)
                } else {
                    // Store for when the stream connects
                    pendingDeepLink = uri
                }
            }
        }
    }
}

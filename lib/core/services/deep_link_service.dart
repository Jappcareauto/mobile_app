import 'dart:async';

import 'package:flutter/services.dart';

/// Listens for deep links forwarded from native Android via an EventChannel.
///
/// On Android, [MainActivity.kt] captures `onNewIntent` and sends the URI
/// string through the `com.jappcare/deep_link` EventChannel. This class
/// exposes that as a Dart [Stream<Uri>] — no third-party plugin needed.
class DeepLinkService {
  DeepLinkService._();
  static final DeepLinkService instance = DeepLinkService._();

  static const EventChannel _channel = EventChannel('com.jappcare/deep_link');

  Stream<Uri>? _stream;

  /// A broadcast stream of deep link URIs received from the platform.
  Stream<Uri> get linkStream {
    _stream ??= _channel
        .receiveBroadcastStream()
        .where((event) => event is String && event.isNotEmpty)
        .map((event) => Uri.parse(event as String))
        .asBroadcastStream();
    return _stream!;
  }
}

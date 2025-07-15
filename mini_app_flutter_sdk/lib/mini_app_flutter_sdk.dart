import 'package:flutter/services.dart';

class MiniAppFlutterSdk {
  static const MethodChannel _channel = MethodChannel('mini_app_flutter_sdk');

  /// Gọi native mở miniapp (WebView)
  static Future<void> openMiniApp() async {
    await _channel.invokeMethod('openMiniApp');
  }
}

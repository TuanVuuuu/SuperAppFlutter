import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'mini_app_flutter_sdk_platform_interface.dart';

/// An implementation of [MiniAppFlutterSdkPlatform] that uses method channels.
class MethodChannelMiniAppFlutterSdk extends MiniAppFlutterSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('mini_app_flutter_sdk');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}

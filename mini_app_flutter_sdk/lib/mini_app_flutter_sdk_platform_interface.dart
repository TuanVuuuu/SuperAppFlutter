import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'mini_app_flutter_sdk_method_channel.dart';

abstract class MiniAppFlutterSdkPlatform extends PlatformInterface {
  /// Constructs a MiniAppFlutterSdkPlatform.
  MiniAppFlutterSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static MiniAppFlutterSdkPlatform _instance = MethodChannelMiniAppFlutterSdk();

  /// The default instance of [MiniAppFlutterSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelMiniAppFlutterSdk].
  static MiniAppFlutterSdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MiniAppFlutterSdkPlatform] when
  /// they register themselves.
  static set instance(MiniAppFlutterSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mini_app_flutter_sdk/mini_app_flutter_sdk_platform_interface.dart';
import 'package:mini_app_flutter_sdk/mini_app_flutter_sdk_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMiniAppFlutterSdkPlatform
    with MockPlatformInterfaceMixin
    implements MiniAppFlutterSdkPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

class MiniAppFlutterSdk {
  Future<String?> getPlatformVersion() {
    return MiniAppFlutterSdkPlatform.instance.getPlatformVersion();
  }
}

void main() {
  final MiniAppFlutterSdkPlatform initialPlatform =
      MiniAppFlutterSdkPlatform.instance;

  test('$MethodChannelMiniAppFlutterSdk is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMiniAppFlutterSdk>());
  });

  test('getPlatformVersion', () async {
    MiniAppFlutterSdk miniAppFlutterSdkPlugin = MiniAppFlutterSdk();
    MockMiniAppFlutterSdkPlatform fakePlatform =
        MockMiniAppFlutterSdkPlatform();
    MiniAppFlutterSdkPlatform.instance = fakePlatform;

    expect(await miniAppFlutterSdkPlugin.getPlatformVersion(), '42');
  });
}

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_app_flutter_sdk/mini_app_flutter_sdk_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelMiniAppFlutterSdk platform = MethodChannelMiniAppFlutterSdk();
  const MethodChannel channel = MethodChannel('mini_app_flutter_sdk');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}

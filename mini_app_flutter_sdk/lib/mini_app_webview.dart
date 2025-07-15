import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MiniAppWebView extends StatelessWidget {
  final String? initialUrl;
  const MiniAppWebView({Key? key, this.initialUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'mini_app_flutter_sdk/webview',
        creationParams: {if (initialUrl != null) 'initialUrl': initialUrl},
        creationParamsCodec: const StandardMessageCodec(),
      );
    }
    return const Text('MiniAppWebView chỉ hỗ trợ Android');
  }
}

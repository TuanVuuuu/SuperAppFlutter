import 'package:flutter/material.dart';
import 'package:mini_app_flutter_sdk/mini_app_flutter_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super App Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Super App Flutter')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await MiniAppFlutterSdk.openMiniApp();
          },
          child: const Text('Mở Mini App'),
        ),
      ),
    );
  }
}

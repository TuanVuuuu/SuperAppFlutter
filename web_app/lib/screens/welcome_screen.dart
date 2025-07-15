import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/welcome_controller.dart';

class WelcomeScreen extends GetView<WelcomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chào mừng')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Chào mừng', style: TextStyle(fontSize: 28)),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: controller.goToScreen2,
              child: Text('Đi tới màn 2'),
            ),
          ],
        ),
      ),
    );
  }
}

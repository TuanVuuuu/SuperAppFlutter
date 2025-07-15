import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/screen2_controller.dart';

class Screen2 extends StatelessWidget {
  final Screen2Controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Màn 2')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Chào mừng đến với màn 2', style: TextStyle(fontSize: 28)),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: controller.goToScreen3,
              child: Text('Đi tới màn 3'),
            ),
          ],
        ),
      ),
    );
  }
}

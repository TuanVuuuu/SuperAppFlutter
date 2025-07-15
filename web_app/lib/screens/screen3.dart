import 'package:flutter/material.dart';

class Screen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Màn 3')),
      body: Center(
        child: Text('Chào mừng đến với màn 3', style: TextStyle(fontSize: 28)),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Mini Web App',
      initialRoute: '/',
      getPages: AppRouter.routes,
    );
  }
}

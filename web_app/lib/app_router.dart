import 'package:get/get.dart';
import 'screens/welcome_screen.dart';
import 'screens/screen2.dart';
import 'screens/screen3.dart';
import 'controllers/welcome_controller.dart';
import 'controllers/screen2_controller.dart';

class AppRouter {
  static final routes = [
    GetPage(
      name: '/',
      page: () => WelcomeScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<WelcomeController>(() => WelcomeController());
      }),
    ),
    GetPage(
      name: '/screen2',
      page: () => Screen2(),
      binding: BindingsBuilder(() {
        Get.lazyPut<Screen2Controller>(() => Screen2Controller());
      }),
    ),
    GetPage(name: '/screen3', page: () => Screen3()),
  ];
}

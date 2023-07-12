import 'package:get/get.dart';
import 'package:mirai_dev_order_monitoring/app/modules/home/controllers/home_controller.dart';
import 'package:mirai_dev_order_monitoring/app/modules/login/controllers/login_controller.dart';

import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}

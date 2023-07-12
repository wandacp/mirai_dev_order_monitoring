import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mirai_dev_order_monitoring/app/modules/auth/views/loading_view.dart';
import 'package:mirai_dev_order_monitoring/app/modules/home/views/home_view.dart';
import 'package:mirai_dev_order_monitoring/app/modules/login/views/login_view.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoadingData.isTrue
          ? LoadingView()
          : controller.user.value != null
              ? HomeView()
              : LoginView(),
    );
  }
}

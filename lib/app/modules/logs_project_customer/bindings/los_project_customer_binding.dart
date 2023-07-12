import 'package:get/get.dart';

import '../controllers/los_project_customer_controller.dart';

class LogsProjectCustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LogsProjectCustomerController>(
      () => LogsProjectCustomerController(),
    );
  }
}

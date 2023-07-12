import 'package:get/get.dart';

import '../controllers/logs_project_controller.dart';

class LogsProjectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LogsProjectController>(
      () => LogsProjectController(),
    );
  }
}

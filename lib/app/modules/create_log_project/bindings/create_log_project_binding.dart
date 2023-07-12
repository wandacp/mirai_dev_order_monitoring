import 'package:get/get.dart';

import '../controllers/create_log_project_controller.dart';

class CreateLogProjectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateLogProjectController>(
      () => CreateLogProjectController(),
    );
  }
}

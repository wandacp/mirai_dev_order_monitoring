import 'package:get/get.dart';

import '../controllers/create_update_project_controller.dart';

class CreateUpdateProjectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateUpdateProjectController>(
      () => CreateUpdateProjectController(),
    );
  }
}

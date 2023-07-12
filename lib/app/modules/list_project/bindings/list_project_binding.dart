import 'package:get/get.dart';

import '../controllers/list_project_controller.dart';

class ListProjectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListProjectController>(
      () => ListProjectController(),
    );
  }
}

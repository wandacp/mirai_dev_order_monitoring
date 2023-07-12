import 'package:get/get.dart';

import '../controllers/create_update_error_bug_controller.dart';

class CreateUpdateErrorBugBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateUpdateErrorBugController>(
      () => CreateUpdateErrorBugController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/update_project_customer_controller.dart';

class UpdateProjectCustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateProjectCustomerController>(
      () => UpdateProjectCustomerController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/list_project_customer_controller.dart';

class ListProjectCustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListProjectCustomerController>(
      () => ListProjectCustomerController(),
    );
  }
}

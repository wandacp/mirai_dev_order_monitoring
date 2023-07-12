import 'package:get/get.dart';

import '../controllers/create_update_customer_controller.dart';

class CreateUpdateCustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateUpdateCustomerController>(
      () => CreateUpdateCustomerController(),
    );
  }
}

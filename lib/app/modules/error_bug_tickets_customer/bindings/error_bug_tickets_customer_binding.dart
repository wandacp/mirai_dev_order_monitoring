import 'package:get/get.dart';

import '../controllers/error_bug_tickets_customer_controller.dart';

class ErrorBugTicketsCustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ErrorBugTicketsCustomerController>(
      () => ErrorBugTicketsCustomerController(),
    );
  }
}

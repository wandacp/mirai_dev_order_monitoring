import 'package:get/get.dart';

import '../controllers/error_bug_tickets_controller.dart';

class ErrorBugTicketsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ErrorBugTicketsController>(
      () => ErrorBugTicketsController(),
    );
  }
}

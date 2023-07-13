import 'package:get/get.dart';

class LupaPasswordController extends GetxController {
  Rxn<String?> email = Rxn<String?>();
  Rx<bool> isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void toggleIsLoading() {
    this.isLoading.toggle();
  }

  void setEmail(String? email) {
    this.email.value = email;
  }
}

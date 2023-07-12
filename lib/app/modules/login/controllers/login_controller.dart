import 'package:get/get.dart';

class LoginController extends GetxController {
  Rxn<String?> email = Rxn<String?>();
  Rxn<String?> password = Rxn<String?>();
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
  void onClose() {}

  void toggleIsLoading() {
    this.isLoading.toggle();
  }

  void setEmail(String? email) {
    this.email.value = email;
  }

  void setPassword(String? password) {
    this.password.value = password;
  }
}

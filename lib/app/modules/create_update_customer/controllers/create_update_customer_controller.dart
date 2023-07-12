import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirai_dev_order_monitoring/app/models/user_app.dart';
import 'package:mirai_dev_order_monitoring/firebase_options.dart';

class CreateUpdateCustomerController extends GetxController {
  TextEditingController namaController = TextEditingController();
  TextEditingController nomorHPController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  Rxn<UserApp?> userApp = Rxn<UserApp?>();
  Rxn<String?> type = Rxn<String?>();
  Rx<bool> isLoading = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    this.type.value = Get.parameters['type'];
    String? uid = Get.parameters['uid'];

    this.userApp.value = UserApp();

    if (type.value == "update") {
      if (uid != null) {
        await loadDataUser(uid);

        namaController.text = this.userApp.value?.nama ?? "";
        nomorHPController.text = this.userApp.value?.nomorHP ?? "";
        emailController.text = this.userApp.value?.email ?? "";
      }
    }
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

  Future<void> loadDataUser(String uid) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get()
        .then((value) {
      this.userApp.value =
          UserApp.fromJson(value.data() as Map<String, dynamic>);
    });
  }

  Future<void> updateDataCustomer(UserApp userApp) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userApp.uid)
        .update(userApp.toJson())
        .then((value) {
      Get.back();

      Get.snackbar("Data Customer Updated",
          "Akun customer telah berhasil diupdate di aplikasi web.");
    });
  }

  Future<void> createDataCustomer(UserApp userApp) async {
    FirebaseApp tempApp = await Firebase.initializeApp(
      name: "Temporary",
      options: DefaultFirebaseOptions.currentPlatform,
    );

    try {
      FirebaseAuth.instanceFor(app: tempApp)
          .createUserWithEmailAndPassword(
        email: userApp.email!,
        password: "110199",
      )
          .then((value) async {
        userApp.uid = value.user!.uid;
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userApp.uid)
            .set(userApp.toJson())
            .then((value) async {
          Get.back();

          Get.snackbar("Data Customer Created",
              "Akun customer telah berhasil didaftarkan di aplikasi web.");
        });
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        Get.snackbar("Create Failed", "Email anda telah terdaftar");
      }
    } catch (e) {
      print(e);
    }
  }
}

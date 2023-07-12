import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirai_dev_order_monitoring/app/models/item_project.dart';
import 'package:mirai_dev_order_monitoring/app/models/user_app.dart';
import 'package:mirai_dev_order_monitoring/app/modules/auth/controllers/auth_controller.dart';

class UpdateProjectCustomerController extends GetxController {
  TextEditingController namaProjectController = TextEditingController();
  TextEditingController deskripsiProjectController = TextEditingController();

  AuthController _authController = Get.find<AuthController>();

  RxList<UserApp> listCustomer = <UserApp>[].obs;
  Rxn<ItemProject?> itemProject = Rxn<ItemProject?>();
  Rxn<UserApp?> customerTerpilih = Rxn<UserApp?>();
  Rx<bool> isLoading = false.obs;
  Rx<bool> isLoadingData = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    String? id = Get.parameters['id'];

    this.itemProject.value = ItemProject();

    toggleIsLoadingData();

    await loadDataCustomer();

    if (id != null) {
      await loadDataProject(id);

      namaProjectController.text = this.itemProject.value?.namaProject ?? "";
      deskripsiProjectController.text =
          this.itemProject.value?.deskripsiProject ?? "";
    }

    toggleIsLoadingData();
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

  void toggleIsLoadingData() {
    this.isLoadingData.toggle();
  }

  Future<void> loadDataCustomer() async {
    List<UserApp> tempListCustomer = [];

    var customerDocs = (await FirebaseFirestore.instance
            .collection("users")
            .where("uid", isEqualTo: _authController.userApp.value!.uid)
            .get())
        .docs;

    customerDocs.forEach((element) {
      tempListCustomer.add(UserApp.fromJson(element.data()));
    });

    this.listCustomer.value = tempListCustomer;
  }

  Future<void> loadDataProject(String id) async {
    await FirebaseFirestore.instance
        .collection("projects")
        .doc(id)
        .get()
        .then((value) async {
      this.itemProject.value =
          ItemProject.fromJson(value.data() as Map<String, dynamic>);

      await FirebaseFirestore.instance
          .collection("users")
          .doc(this.itemProject.value!.uidCustomer)
          .get()
          .then((value) {
        this.customerTerpilih.value =
            UserApp.fromJson(value.data() as Map<String, dynamic>);
      });
    });
  }

  Future<void> updateDataProject(ItemProject itemProject) async {
    await FirebaseFirestore.instance
        .collection("projects")
        .doc(itemProject.id)
        .update(itemProject.toJson())
        .then((value) {
      Get.back();

      Get.snackbar("Data Project Updated",
          "Data project telah berhasil diupdate di aplikasi web.");
    });
  }

  Future<void> createDataProject(ItemProject itemProject) async {
    await FirebaseFirestore.instance
        .collection("projects")
        .add(itemProject.toJson())
        .then((value) {
      value.update({
        "id": value.id,
      });

      Get.back();
    });
  }
}

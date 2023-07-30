import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirai_dev_order_monitoring/app/models/error_bug.dart';
import 'package:mirai_dev_order_monitoring/app/models/item_project.dart';
import 'package:mirai_dev_order_monitoring/app/modules/auth/controllers/auth_controller.dart';

class CreateUpdateErrorBugController extends GetxController {
  final AuthController _authController = Get.find<AuthController>();

  TextEditingController deskripsiProjectController = TextEditingController();

  Rxn<ErrorBug?> errorBug = Rxn<ErrorBug?>();
  RxList<ItemProject> listProject = <ItemProject>[].obs;
  Rxn<ItemProject?> itemProjectTerpilih = Rxn<ItemProject?>();
  Rxn<String?> type = Rxn<String?>();
  Rx<bool> isLoading = false.obs;
  Rx<String> fileNameUploaded = "".obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    this.type.value = Get.parameters['type'];
    String? id = Get.parameters['id'];

    this.errorBug.value = ErrorBug(
      uidCustomer: _authController.userApp.value!.uid,
    );

    if (type.value == "update") {
      if (id != null) {
        await loadDataErrorBug(id);

        deskripsiProjectController.text = this.errorBug.value?.deskripsi ?? "";
      }
    }

    await loadDataProject();
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

  Future<void> loadDataErrorBug(String id) async {
    await FirebaseFirestore.instance
        .collection("errorbugs")
        .doc(id)
        .get()
        .then((value) async {
      this.errorBug.value =
          ErrorBug.fromJson(value.data() as Map<String, dynamic>);

      await FirebaseFirestore.instance
          .collection("projects")
          .doc(this.errorBug.value!.idProject)
          .get()
          .then((value) {
        this.itemProjectTerpilih.value =
            ItemProject.fromJson(value.data() as Map<String, dynamic>);
      });
    });
  }

  Future<void> loadDataProject() async {
    List<ItemProject> tempListProject = [];

    var customerDocs = (await FirebaseFirestore.instance
            .collection("projects")
            .where("uidCustomer", isEqualTo: _authController.userApp.value!.uid)
            .get())
        .docs;

    customerDocs.forEach((element) {
      tempListProject.add(ItemProject.fromJson(element.data()));
    });

    this.listProject.value = tempListProject;
  }

  Future<void> updateDataErrorBug(ErrorBug errorBug) async {
    await FirebaseFirestore.instance
        .collection("errorbugs")
        .doc(errorBug.id)
        .update(errorBug.toJson())
        .then((value) {
      Get.back();

      Get.snackbar("Data Error & Bug Updated",
          "Data error & bug telah berhasil diupdate di aplikasi web.");
    });
  }

  Future<void> createDataErrorBug(ErrorBug errorBug) async {
    await FirebaseFirestore.instance
        .collection("errorbugs")
        .add(errorBug.toJson())
        .then((value) {
      value.update({
        "id": value.id,
      });

      Get.back();
    });
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mirai_dev_order_monitoring/app/models/item_project.dart';
import 'package:mirai_dev_order_monitoring/app/models/log_project.dart';

class CreateLogProjectController extends GetxController {
  Rxn<ItemProject?> itemProject = Rxn<ItemProject?>();
  Rxn<LogProject?> logProject = Rxn<LogProject?>();
  Rx<bool> isLoading = false.obs;
  Rx<String> fileNameUploaded = "".obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    String? id = Get.parameters['id'];

    this.itemProject.value = ItemProject();
    this.logProject.value = LogProject();

    if (id != null) {
      await loadDataProject(id);
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

  Future<void> loadDataProject(String id) async {
    await FirebaseFirestore.instance
        .collection("projects")
        .doc(id)
        .get()
        .then((value) {
      this.itemProject.value =
          ItemProject.fromJson(value.data() as Map<String, dynamic>);
    });
  }

  Future<void> updateDataProject(ItemProject itemProject) async {
    await FirebaseFirestore.instance
        .collection("projects")
        .doc(itemProject.id)
        .update(itemProject.toJson())
        .then((value) async {
      await loadDataProject(itemProject.id!);

      Get.back();

      Get.snackbar("Data Project Updated",
          "Data project telah berhasil diupdate di aplikasi web.");
    });
  }
}

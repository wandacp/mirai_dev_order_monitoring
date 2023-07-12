import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mirai_dev_order_monitoring/app/models/item_project.dart';

class LogsProjectController extends GetxController {
  Rxn<ItemProject?> itemProject = Rxn<ItemProject?>();
  Rx<bool> isLoading = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    String? id = Get.parameters['id'];

    this.itemProject.value = ItemProject();

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
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:mirai_dev_order_monitoring/app/data/fonts.dart';
import 'package:mirai_dev_order_monitoring/app/models/item_project.dart';

import '../controllers/create_update_error_bug_controller.dart';

class CreateUpdateErrorBugView extends GetView<CreateUpdateErrorBugController> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            controller.type.value == "create"
                ? 'Create Error & Bug'
                : 'Update Error & Bug',
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16.r),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "NAMA PROJECT",
                  style: textStyle2.copyWith(
                    color: Colors.black,
                    fontSize: 12.sp,
                  ),
                ),
                Obx(
                  () => Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButtonFormField<ItemProject?>(
                        style: textStyle1.copyWith(
                          color: Colors.black,
                          fontSize: 12.sp,
                        ),
                        value: controller.itemProjectTerpilih.value,
                        icon: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.r),
                          child: Icon(
                            FontAwesomeIcons.circleChevronDown,
                            color: Colors.black,
                            size: 12.r,
                          ),
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 16.r),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2.r,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                        ),
                        onChanged: (ItemProject? value) {
                          if (value != null) {
                            controller.errorBug.update((val) {
                              val!.idProject = value.id;
                            });
                          }
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Nama project tidak boleh kosong';
                          }

                          return null;
                        },
                        items: controller.listProject
                            .map<DropdownMenuItem<ItemProject>>(
                                (ItemProject value) {
                          return DropdownMenuItem<ItemProject>(
                            value: value,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.r),
                                child: Text(
                                  value.namaProject ?? "-",
                                  style: textStyle1.copyWith(
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        selectedItemBuilder: (context) {
                          return controller.listProject
                              .map<Widget>((ItemProject item) {
                            return Text(
                              item.namaProject ?? "-",
                              style: textStyle1.copyWith(
                                color: Colors.black,
                                fontSize: 12.sp,
                              ),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  "PRIORITAS",
                  style: textStyle2.copyWith(
                    color: Colors.black,
                    fontSize: 12.sp,
                  ),
                ),
                Obx(
                  () => Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButtonFormField<String?>(
                        style: textStyle1.copyWith(
                          color: Colors.black,
                          fontSize: 12.sp,
                        ),
                        value: controller.errorBug.value!.prioritas ?? "Low",
                        icon: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.r),
                          child: Icon(
                            FontAwesomeIcons.circleChevronDown,
                            color: Colors.black,
                            size: 12.r,
                          ),
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 16.r),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2.r,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                        ),
                        onChanged: (String? value) {
                          if (value != null) {
                            controller.errorBug.update((val) {
                              val!.prioritas = value;
                            });
                          }
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Prioritas tidak boleh kosong';
                          }

                          return null;
                        },
                        items: ["Low", "Medium", "High"]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.r),
                                child: Text(
                                  value,
                                  style: textStyle1.copyWith(
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        selectedItemBuilder: (context) {
                          return ["Low", "Medium", "High"]
                              .map<Widget>((String item) {
                            return Text(
                              item,
                              style: textStyle1.copyWith(
                                color: Colors.black,
                                fontSize: 12.sp,
                              ),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  "STATUS",
                  style: textStyle2.copyWith(
                    color: Colors.black,
                    fontSize: 12.sp,
                  ),
                ),
                Obx(
                  () => Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButtonFormField<String?>(
                        style: textStyle1.copyWith(
                          color: Colors.black,
                          fontSize: 12.sp,
                        ),
                        value: controller.errorBug.value!.status ?? "Reported",
                        icon: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.r),
                          child: Icon(
                            FontAwesomeIcons.circleChevronDown,
                            color: Colors.black,
                            size: 12.r,
                          ),
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 16.r),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2.r,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                        ),
                        onChanged: (String? value) {
                          if (value != null) {
                            controller.errorBug.update((val) {
                              val!.status = value;
                            });
                          }
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Status tidak boleh kosong';
                          }

                          return null;
                        },
                        items: ["Reported", "On Progress", "Solved", "Failed"]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.r),
                                child: Text(
                                  value,
                                  style: textStyle1.copyWith(
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        selectedItemBuilder: (context) {
                          return ["Reported", "On Progress", "Solved", "Failed"]
                              .map<Widget>((String item) {
                            return Text(
                              item,
                              style: textStyle1.copyWith(
                                color: Colors.black,
                                fontSize: 12.sp,
                              ),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  "DESKRIPSI PROJECT",
                  style: textStyle2.copyWith(
                    color: Colors.black,
                    fontSize: 12.sp,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: TextFormField(
                    controller: controller.deskripsiProjectController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.r),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1.r,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.r),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1.r,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.r),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1.r,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Deskripsi project tidak boleh kosong';
                      }

                      return null;
                    },
                    onChanged: (value) {
                      controller.errorBug.update((val) {
                        val!.deskripsi = value;
                      });
                    },
                    keyboardType: TextInputType.text,
                    minLines: 5,
                    maxLines: 10,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  "DOKUMEN (OPTIONAL)",
                  style: textStyle2.copyWith(
                    color: Colors.black,
                    fontSize: 12.sp,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['pdf'],
                    );

                    if (result != null) {
                      Uint8List? fileBytes = result.files.first.bytes;

                      if (fileBytes != null) {
                        try {
                          await FirebaseStorage.instanceFor(
                                  bucket:
                                      "gs://mirai-dev-order-monitoring.appspot.com")
                              .ref()
                              .child("${controller.errorBug.value!.idProject}")
                              .putData(fileBytes)
                              .then((value) {
                            controller.errorBug.update((val) async {
                              val!.dokumen = await value.ref.getDownloadURL();
                            });
                          });
                        } on FirebaseException catch (e) {
                          print(e);
                        }
                      }
                    }
                  },
                  child: Container(
                    height: 48.r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      border: Border.all(
                        color: Colors.black,
                        width: 1.r,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.h,
                ),
                Obx(
                  () => ElevatedButton(
                    onPressed: () async {
                      bool isValid = _formKey.currentState?.validate() ?? false;

                      if (isValid) {
                        controller.toggleIsLoading();

                        if (controller.type.value == "update") {
                          controller.errorBug.update((val) {
                            val!.tanggal = Timestamp.fromDate(DateTime.now());
                          });

                          await controller
                              .updateDataErrorBug(controller.errorBug.value!);
                        } else {
                          controller.errorBug.update((val) {
                            val!.tanggal = Timestamp.fromDate(DateTime.now());
                          });

                          await controller
                              .createDataErrorBug(controller.errorBug.value!);
                        }

                        controller.toggleIsLoading();
                      }
                    },
                    child: SizedBox(
                      height: 56.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          controller.isLoading.isTrue
                              ? SizedBox(
                                  height: 32.r,
                                  width: 32.r,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.type.value == "create"
                                          ? 'Create Error & Bug'
                                          : 'Update Error & Bug',
                                      style: textStyle1.copyWith(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(0.r),
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

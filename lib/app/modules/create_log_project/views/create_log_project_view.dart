import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:mirai_dev_order_monitoring/app/data/fonts.dart';
import 'package:mirai_dev_order_monitoring/app/models/log_project.dart';

import '../controllers/create_log_project_controller.dart';

class CreateLogProjectView extends GetView<CreateLogProjectController> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Log Project'),
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
                  "STATUS",
                  style: textStyle2.copyWith(
                    color: Colors.black,
                    fontSize: 12.sp,
                  ),
                ),
                Container(
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
                      value: null,
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
                          controller.logProject.update((val) {
                            val!.status = value;
                          });
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Status tidak boleh kosong';
                        }

                        return null;
                      },
                      items: [
                        "Down Payment",
                        "Requirement Fixed",
                        "Design Fixed",
                        "System Development",
                        "System Testing",
                        "User Acceptance Testing",
                        "BAST",
                      ].map<DropdownMenuItem<String>>((String value) {
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
                        return [
                          "Down Payment",
                          "Requirement Fixed",
                          "Design Fixed",
                          "System Development",
                          "System Testing",
                          "User Acceptance Testing",
                          "BAST",
                        ].map<Widget>((String item) {
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
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  "CATATAN",
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
                        return 'Catatan log project tidak boleh kosong';
                      }

                      return null;
                    },
                    onChanged: (value) {
                      controller.logProject.update((val) {
                        val!.catatan = value;
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
                    );

                    if (result != null) {
                      Uint8List? fileBytes = result.files.first.bytes;

                      if (fileBytes != null) {
                        try {
                          await FirebaseStorage.instanceFor(
                                  bucket:
                                      "gs://mirai-dev-order-monitoring.appspot.com")
                              .ref()
                              .child(
                                  "${controller.itemProject.value!.namaProject}-${controller.itemProject.value!.logProject == null ? 1 : (controller.itemProject.value!.logProject!.length + 1)}")
                              .putData(fileBytes)
                              .then((value) {
                            controller.logProject.update((val) async {
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

                        List<LogProject> tempListLogProject =
                            controller.itemProject.value!.logProject ?? [];

                        controller.logProject.update((val) {
                          val!.tanggalLog = Timestamp.fromDate(DateTime.now());
                        });

                        tempListLogProject.add(controller.logProject.value!);

                        controller.itemProject.update((val) {
                          val!.tanggalUpdated =
                              Timestamp.fromDate(DateTime.now());
                          val.logProject = tempListLogProject;
                        });

                        print(controller.itemProject.value!.logProject);

                        await controller
                            .updateDataProject(controller.itemProject.value!);

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
                                      'Create Log Project',
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

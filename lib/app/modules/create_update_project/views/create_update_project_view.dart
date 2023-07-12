import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:mirai_dev_order_monitoring/app/data/fonts.dart';
import 'package:mirai_dev_order_monitoring/app/models/user_app.dart';

import '../controllers/create_update_project_controller.dart';

class CreateUpdateProjectView extends GetView<CreateUpdateProjectController> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            controller.type.value == "create"
                ? 'Create Project'
                : 'Update Project',
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
                  "Nama Customer",
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
                      child: DropdownButtonFormField<UserApp?>(
                        style: textStyle1.copyWith(
                          color: Colors.black,
                          fontSize: 12.sp,
                        ),
                        value: controller.customerTerpilih.value,
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
                        onChanged: (UserApp? value) {
                          if (value != null) {
                            controller.itemProject.update((val) {
                              val!.uidCustomer = value.uid;
                            });
                          }
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Nama customer tidak boleh kosong';
                          }

                          return null;
                        },
                        items: controller.listCustomer
                            .map<DropdownMenuItem<UserApp>>((UserApp value) {
                          return DropdownMenuItem<UserApp>(
                            value: value,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.r),
                                child: Text(
                                  value.nama ?? "-",
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
                          return controller.listCustomer
                              .map<Widget>((UserApp item) {
                            return Text(
                              item.nama ?? "-",
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
                  "NAMA PROJECT",
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
                    controller: controller.namaProjectController,
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
                        return 'Nama project tidak boleh kosong';
                      }

                      return null;
                    },
                    onChanged: (value) {
                      controller.itemProject.update((val) {
                        val!.namaProject = value;
                      });
                    },
                    keyboardType: TextInputType.name,
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
                      controller.itemProject.update((val) {
                        val!.deskripsiProject = value;
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
                  "APAKAH CUSTOMER BOLEH UPDATE ?",
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
                        value: (controller.itemProject.value!
                                    .isAllowToUpdateByCustomer ==
                                true)
                            ? "Ya"
                            : "Tidak",
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
                            controller.itemProject.update((val) {
                              if (value == "Ya") {
                                val!.isAllowToUpdateByCustomer = true;
                              } else {
                                val!.isAllowToUpdateByCustomer = false;
                              }
                            });
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Pilihan tidak boleh kosong';
                          }

                          return null;
                        },
                        items: ["Ya", "Tidak"]
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
                          return ["Ya", "Tidak"].map<Widget>((String item) {
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
                  height: 48.h,
                ),
                Obx(
                  () => ElevatedButton(
                    onPressed: () async {
                      bool isValid = _formKey.currentState?.validate() ?? false;

                      if (isValid) {
                        controller.toggleIsLoading();

                        if (controller.type.value == "update") {
                          controller.itemProject.update((val) {
                            val!.tanggalUpdated =
                                Timestamp.fromDate(DateTime.now());
                          });

                          await controller
                              .updateDataProject(controller.itemProject.value!);
                        } else {
                          controller.itemProject.update((val) {
                            val!.tanggalCreated =
                                Timestamp.fromDate(DateTime.now());
                          });

                          await controller
                              .createDataProject(controller.itemProject.value!);
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
                                          ? 'Create Project'
                                          : 'Update Project',
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

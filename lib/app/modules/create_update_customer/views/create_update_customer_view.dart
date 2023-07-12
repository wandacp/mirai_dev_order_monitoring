import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:mirai_dev_order_monitoring/app/data/fonts.dart';

import '../controllers/create_update_customer_controller.dart';

class CreateUpdateCustomerView extends GetView<CreateUpdateCustomerController> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            controller.type.value == "create"
                ? 'Create Customer'
                : 'Update Customer',
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
                  "NAMA",
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
                    controller: controller.namaController,
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
                        return 'Nama tidak boleh kosong';
                      }

                      return null;
                    },
                    onChanged: (value) {
                      controller.userApp.update((val) {
                        val!.nama = value;
                      });
                    },
                    keyboardType: TextInputType.name,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  "NOMOR HP",
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
                    controller: controller.nomorHPController,
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
                        return 'Nomor HP tidak boleh kosong';
                      }

                      return null;
                    },
                    onChanged: (value) {
                      controller.userApp.update((val) {
                        val!.nomorHP = value;
                      });
                    },
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  "EMAIL",
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
                    controller: controller.emailController,
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
                        return 'Email tidak boleh kosong';
                      } else if (!value.isEmail) {
                        return 'Format email salah';
                      }

                      return null;
                    },
                    onChanged: (value) {
                      controller.userApp.update((val) {
                        val!.email = value;
                      });
                    },
                    keyboardType: TextInputType.emailAddress,
                    enabled: (controller.type.value == "update") ? false : true,
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
                          await controller
                              .updateDataCustomer(controller.userApp.value!);
                        } else {
                          controller.userApp.update((val) {
                            val!.roleUser = "Customer";
                          });

                          await controller
                              .createDataCustomer(controller.userApp.value!);
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
                                          ? 'Create Customer'
                                          : 'Update Customer',
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

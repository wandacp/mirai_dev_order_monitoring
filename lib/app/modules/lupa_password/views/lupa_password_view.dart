import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:mirai_dev_order_monitoring/app/data/fonts.dart';
import 'package:mirai_dev_order_monitoring/app/modules/auth/controllers/auth_controller.dart';

import '../controllers/lupa_password_controller.dart';

class LupaPasswordView extends GetView<LupaPasswordController> {
  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lupa Password'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16.r),
        child: ListView(
          children: [
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
                  controller.setEmail(value);
                },
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            SizedBox(
              height: 48.h,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Obx(
                () => ElevatedButton(
                  onPressed: () async {
                    String email = controller.email.value!;

                    controller.toggleIsLoading();

                    await _authController.lupaPassword(email);

                    controller.toggleIsLoading();
                  },
                  child: SizedBox(
                    height: 56.h,
                    child: Padding(
                      padding: EdgeInsets.all(10.r),
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
                                      "KIRIM LINK RESET PASSWORD",
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
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

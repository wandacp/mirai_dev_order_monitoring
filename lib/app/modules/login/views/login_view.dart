import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:mirai_dev_order_monitoring/app/data/fonts.dart';
import 'package:mirai_dev_order_monitoring/app/modules/auth/controllers/auth_controller.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final _formLoginKey = GlobalKey<FormState>();
  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey.withOpacity(0.1),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo_tulisan.png",
                height: 100.r,
              ),
              SizedBox(
                height: 32.h,
              ),
              Text(
                'MiraiDev | Order Monitoring',
                style: textStyle1.copyWith(
                  color: Colors.black,
                  fontSize: 32.sp,
                ),
              ),
              SizedBox(
                height: 32.h,
              ),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Container(
                  padding: EdgeInsets.all(32.r),
                  width: 0.33.sw,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Form(
                    key: _formLoginKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          height: 16.h,
                        ),
                        Text(
                          "PASSWORD",
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
                                return 'Password tidak boleh kosong';
                              }

                              return null;
                            },
                            onChanged: (value) {
                              controller.setPassword(value);
                            },
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                          ),
                        ),
                        SizedBox(
                          height: 48.h,
                        ),
                        Container(
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Obx(
                            () => ElevatedButton(
                              onPressed: () async {
                                bool isValid =
                                    _formLoginKey.currentState?.validate() ??
                                        false;

                                if (isValid) {
                                  String email = controller.email.value!;
                                  String password = controller.password.value!;

                                  controller.toggleIsLoading();

                                  await _authController.loginUser(
                                      email, password);

                                  controller.toggleIsLoading();
                                }
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "LOGIN",
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

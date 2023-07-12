import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:mirai_dev_order_monitoring/app/data/colors.dart';
import 'package:mirai_dev_order_monitoring/app/data/fonts.dart';
import 'package:mirai_dev_order_monitoring/app/modules/auth/controllers/auth_controller.dart';
import 'package:mirai_dev_order_monitoring/app/modules/home/views/home_admin.dart';
import 'package:mirai_dev_order_monitoring/app/modules/home/views/home_customer.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    clipBehavior: Clip.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    content: Text(
                      "Apakah anda yakin keluar dari sistem ?",
                      style: textStyle1.copyWith(
                        color: ColorHelper.mainColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: ColorHelper.mainColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "Tidak",
                            style: textStyle1.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          await _authController.logoutUser();
                        },
                        child: Text(
                          "Ya",
                          style:
                              textStyle1.copyWith(color: ColorHelper.mainColor),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(
              FontAwesomeIcons.arrowRightFromBracket,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Obx(
        () => _authController.userApp.value!.roleUser == "Admin"
            ? HomeAdmin()
            : HomeCustomer(),
      ),
    );
  }
}

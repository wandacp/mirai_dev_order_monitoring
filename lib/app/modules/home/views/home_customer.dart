import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mirai_dev_order_monitoring/app/data/colors.dart';
import 'package:mirai_dev_order_monitoring/app/data/fonts.dart';
import 'package:mirai_dev_order_monitoring/app/modules/auth/controllers/auth_controller.dart';
import 'package:mirai_dev_order_monitoring/app/routes/app_pages.dart';

class HomeCustomer extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(10.r),
        child: ListView(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorHelper.mainColor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.r),
                      child: Icon(
                        FontAwesomeIcons.user,
                        size: 64.r,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "${_authController.userApp.value!.nama}",
                    style: textStyle1.copyWith(
                      color: ColorHelper.mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "${_authController.userApp.value!.nomorHP}",
                    style: textStyle1.copyWith(
                      color: ColorHelper.mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "${_authController.userApp.value!.email}",
                    style: textStyle1.copyWith(
                      color: ColorHelper.mainColor,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: ColorHelper.mainColor.withOpacity(0.5),
              thickness: 2.r,
            ),
            SizedBox(
              height: 8.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: ColorHelper.mainColor,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.r),
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(Routes.LIST_PROJECT_CUSTOMER);
                          },
                          child: Icon(
                            FontAwesomeIcons.listCheck,
                            size: 64.r,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.r,
                    ),
                    Text(
                      "List\nProject",
                      style: textStyle1.copyWith(
                        color: ColorHelper.mainColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: ColorHelper.mainColor,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.r),
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(Routes.ERROR_BUG_TICKETS_CUSTOMER);
                          },
                          child: Icon(
                            FontAwesomeIcons.bugs,
                            size: 64.r,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.r,
                    ),
                    Text(
                      "Error & Bug\nTickets",
                      style: textStyle1.copyWith(
                        color: ColorHelper.mainColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

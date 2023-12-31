import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mirai_dev_order_monitoring/app/data/colors.dart';
import 'package:mirai_dev_order_monitoring/app/data/fonts.dart';
import 'package:mirai_dev_order_monitoring/app/models/error_bug.dart';
import 'package:mirai_dev_order_monitoring/app/modules/auth/controllers/auth_controller.dart';
import 'package:mirai_dev_order_monitoring/app/routes/app_pages.dart';
import 'package:mirai_dev_order_monitoring/app/utis/convert_waktu.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/error_bug_tickets_customer_controller.dart';

class ErrorBugTicketsCustomerView
    extends GetView<ErrorBugTicketsCustomerController> {
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Error & Bug Tickets'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16.r),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('errorbugs')
              .where("uidCustomer",
                  isEqualTo: _authController.userApp.value!.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                  color: ColorHelper.mainColor,
                  size: 64.r,
                ),
              );
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;

                ErrorBug errorBug = ErrorBug.fromJson(data);

                return Container(
                  margin: EdgeInsets.only(bottom: 8.r),
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: ColorHelper.mainColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            errorBug.status ?? "",
                            style: textStyle1.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(
                            height: 4.r,
                          ),
                          Text(
                            "Catatan : ",
                            style: textStyle1.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.r),
                            child: Text(
                              errorBug.deskripsi ?? "-",
                              style: textStyle1.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4.r,
                          ),
                          Text(
                            errorBug.tanggal != null
                                ? dateTimeToString(errorBug.tanggal!.toDate())
                                : "-",
                            style: textStyle1.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(
                            height: 4.r,
                          ),
                          (errorBug.dokumen != null)
                              ? ElevatedButton(
                                  onPressed: () async {
                                    String urlDownload = errorBug.dokumen!;

                                    final Uri url = Uri.parse(urlDownload);

                                    if (!await launchUrl(url)) {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: Text(
                                    "Dokumen",
                                    style: textStyle1.copyWith(
                                      color: ColorHelper.mainColor,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.yellow,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.r),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.toNamed(
                                  "${Routes.CREATE_UPDATE_ERROR_BUG}/update/${errorBug.id}",
                                );
                              },
                              child: Icon(
                                FontAwesomeIcons.penToSquare,
                                color: Colors.white,
                                size: 24.r,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(
            "${Routes.CREATE_UPDATE_ERROR_BUG}/create/${null}",
          );
        },
        child: Icon(
          FontAwesomeIcons.plus,
          size: 24.r,
          color: Colors.white,
        ),
      ),
    );
  }
}

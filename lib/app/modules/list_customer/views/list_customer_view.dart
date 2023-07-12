import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mirai_dev_order_monitoring/app/data/colors.dart';
import 'package:mirai_dev_order_monitoring/app/data/fonts.dart';
import 'package:mirai_dev_order_monitoring/app/models/user_app.dart';
import 'package:mirai_dev_order_monitoring/app/routes/app_pages.dart';

import '../controllers/list_customer_controller.dart';

class ListCustomerView extends GetView<ListCustomerController> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
      .where("roleUser", isEqualTo: "Customer")
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Customer'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16.r),
        child: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
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

                UserApp userApp = UserApp.fromJson(data);

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
                            userApp.nama ?? "",
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
                            userApp.nomorHP ?? "",
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
                            userApp.email ?? "",
                            style: textStyle1.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(
                            height: 4.r,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.r),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.toNamed(
                                  "${Routes.CREATE_UPDATE_CUSTOMER}/update/${userApp.uid}",
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
            "${Routes.CREATE_UPDATE_CUSTOMER}/create/${null}",
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

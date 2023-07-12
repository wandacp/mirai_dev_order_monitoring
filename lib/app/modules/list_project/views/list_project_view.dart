import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mirai_dev_order_monitoring/app/data/colors.dart';
import 'package:mirai_dev_order_monitoring/app/data/fonts.dart';
import 'package:mirai_dev_order_monitoring/app/models/item_project.dart';
import 'package:mirai_dev_order_monitoring/app/models/user_app.dart';
import 'package:mirai_dev_order_monitoring/app/routes/app_pages.dart';
import 'package:mirai_dev_order_monitoring/app/utis/convert_waktu.dart';

import '../controllers/list_project_controller.dart';

class ListProjectView extends GetView<ListProjectController> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('projects').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Project'),
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

                ItemProject itemProject = ItemProject.fromJson(data);

                return Container(
                  margin: EdgeInsets.only(bottom: 8.r),
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: itemProject.isAllowToUpdateByCustomer == true
                        ? ColorHelper.mainColor
                        : ColorHelper.mainColor.withOpacity(0.75),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FutureBuilder<DocumentSnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(itemProject.uidCustomer)
                                  .get(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return Text("Something went wrong");
                                }

                                if (snapshot.hasData &&
                                    !snapshot.data!.exists) {
                                  return Text("Document does not exist");
                                }

                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  Map<String, dynamic> data = snapshot.data!
                                      .data() as Map<String, dynamic>;

                                  UserApp userApp = UserApp.fromJson(data);
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Nama Customer : ${userApp.nama ?? ""}",
                                        style: textStyle1.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  );
                                }

                                return Text("loading");
                              },
                            ),
                            SizedBox(
                              height: 4.r,
                            ),
                            Text(
                              itemProject.namaProject ?? "",
                              style: textStyle1.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                              ),
                            ),
                            SizedBox(
                              height: 4.r,
                            ),
                            Container(
                              padding: EdgeInsets.all(8.r),
                              child: Text(
                                itemProject.deskripsiProject ?? "",
                                style: textStyle1.copyWith(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 4.r,
                            ),
                            Text(
                              "Kick-Off Project : ${dateTimeToString(itemProject.tanggalCreated!.toDate())}",
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
                              "Last Updated Project : ${itemProject.tanggalUpdated != null ? dateTimeToString(itemProject.tanggalUpdated!.toDate()) : "-"}",
                              style: textStyle1.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.all(16.r),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.toNamed(
                                    "${Routes.LOGS_PROJECT}/${itemProject.id}",
                                  );
                                },
                                child: Icon(
                                  FontAwesomeIcons.timeline,
                                  color: Colors.white,
                                  size: 24.r,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(
                                    "${Routes.CREATE_UPDATE_PROJECT}/update/${itemProject.id}",
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
            "${Routes.CREATE_UPDATE_PROJECT}/create/${null}",
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

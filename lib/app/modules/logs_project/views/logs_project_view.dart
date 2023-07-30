import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:mirai_dev_order_monitoring/app/data/colors.dart';
import 'package:mirai_dev_order_monitoring/app/data/fonts.dart';
import 'package:mirai_dev_order_monitoring/app/routes/app_pages.dart';
import 'package:mirai_dev_order_monitoring/app/utis/convert_waktu.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/logs_project_controller.dart';

class LogsProjectView extends GetView<LogsProjectController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logs Project'),
        centerTitle: true,
      ),
      body: Obx(
        () => Container(
          padding: EdgeInsets.all(16.r),
          child: SingleChildScrollView(
            child: controller.itemProject.value!.logProject == null
                ? Text("Log Project Belum Tersedia")
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0;
                          i < controller.itemProject.value!.logProject!.length;
                          i++)
                        Container(
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
                                    controller.itemProject.value!.logProject![i]
                                            .status ??
                                        "",
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
                                      controller.itemProject.value!
                                              .logProject![i].catatan ??
                                          "-",
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
                                    controller.itemProject.value!.logProject![i]
                                                .tanggalLog !=
                                            null
                                        ? dateTimeToString(controller
                                            .itemProject
                                            .value!
                                            .logProject![i]
                                            .tanggalLog!
                                            .toDate())
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
                                ],
                              ),
                              (controller.itemProject.value!.logProject![i]
                                          .dokumen !=
                                      null)
                                  ? ElevatedButton(
                                      onPressed: () async {
                                        String urlDownload = controller
                                            .itemProject
                                            .value!
                                            .logProject![i]
                                            .dokumen!;

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
                        ),
                    ],
                  ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(
            "${Routes.CREATE_LOG_PROJECT}/${controller.itemProject.value!.id}",
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

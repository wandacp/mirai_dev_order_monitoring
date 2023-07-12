import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:mirai_dev_order_monitoring/app/data/colors.dart';
import 'package:mirai_dev_order_monitoring/app/modules/auth/controllers/auth_controller.dart';
import 'package:mirai_dev_order_monitoring/firebase_options.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initController();
  runApp(
    MainApp(),
  );
}

void initController() {
  Get.put(AuthController(), permanent: true);
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          title: "MiraiDev | Order Monitoring",
          theme: ThemeData(
            colorScheme: ColorScheme(
              brightness: Brightness.light,
              primary: ColorHelper.mainColor,
              onPrimary: Colors.white,
              secondary: ColorHelper.mainColor,
              onSecondary: Colors.white,
              error: Colors.red,
              onError: Colors.red,
              background: ColorHelper.mainColor,
              onBackground: ColorHelper.mainColor,
              surface: Colors.white,
              onSurface: Colors.white,
            ),
          ),
          initialRoute: AppPages.INITIAL,
          debugShowCheckedModeBanner: false,
          getPages: AppPages.routes,
        );
      },
    );
  }
}

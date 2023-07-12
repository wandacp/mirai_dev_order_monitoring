import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mirai_dev_order_monitoring/app/data/colors.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: ColorHelper.mainColor,
              size: 64.r,
            ),
          ),
        ],
      ),
    );
  }
}

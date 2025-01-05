import 'package:deliveryapp/common/constants/app_colors.dart';
import 'package:deliveryapp/features/splash/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      body: Center(
        child: Text(
          "WELCOME",
          style: TextStyle(color: AppColors.primaryColor, fontSize: 30.sp),
        ),
      ),
    );
  }
}

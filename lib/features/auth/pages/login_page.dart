import 'package:deliveryapp/common/constants/app_colors.dart';
import 'package:deliveryapp/common/routers/app_router.dart';
import 'package:deliveryapp/common/widgets/custom_appbar.dart';
import 'package:deliveryapp/common/widgets/custom_button.dart';
import 'package:deliveryapp/common/widgets/custom_textfield.dart';
import 'package:deliveryapp/data/enums/request_status.dart';
import 'package:deliveryapp/features/auth/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      appBar: CustomAppBar(title: "login".tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "welcome_back".tr,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
              SizedBox(height: 10.h),
              Text(
                "please_login".tr,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[700],
                    ),
              ),
              SizedBox(height: 30.h),
              CustomTextField(
                width: 335.w,
                controller: controller.phoneController,
                hintText: "phone".tr,
                keyboardType: TextInputType.phone,
                icon: Icon(Icons.phone),
              ),
              SizedBox(height: 20.h),
              StatefulBuilder(builder: (context, setState) {
                return CustomTextField(
                  obscure: obscure,
                  controller: controller.passwordController,
                  hintText: "password".tr,
                  keyboardType: TextInputType.visiblePassword,
                  maxLines: 1,
                  icon: Icon(Icons.lock),
                  suffix: IconButton(
                    icon: Icon(
                        obscure ? Icons.visibility_off : Icons.visibility,
                        color: obscure ? null : AppColors.primaryColor),
                    onPressed: () {
                      obscure = !obscure;
                      setState(() {});
                    },
                  ),
                );
              }),
              // SizedBox(height: 10.h),
              // Align(
              //   alignment: AlignmentDirectional.centerStart,
              //   child: TextButton(
              //     onPressed: () {},
              //     child: Text(
              //       "Forgot Password?",
              //       style: TextStyle(color: AppColors.primaryColor),
              //     ),
              //   ),
              // ),
              SizedBox(height: 20.h),
              Obx(() => controller.status.value == RequestStatus.loading
                  ? CustomButton(
                      title: "login".tr,
                      onTap: null,
                      loading: true,
                    )
                  : CustomButton(
                      title: "login".tr,
                      onTap: () {
                        controller.login();
                      })),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "dont_have_account".tr,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoute.signupPageUrl);
                    },
                    child: Text(
                      "signup".tr,
                      style: TextStyle(color: AppColors.primaryColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

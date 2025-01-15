import 'package:deliveryapp/common/constants/app_colors.dart';
import 'package:deliveryapp/common/widgets/custom_appbar.dart';
import 'package:deliveryapp/common/widgets/custom_button.dart';
import 'package:deliveryapp/common/widgets/custom_textfield.dart';
import 'package:deliveryapp/data/enums/request_status.dart';
import 'package:deliveryapp/features/auth/controllers/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  bool obscure = true;
  bool obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    final SignupController controller = Get.put(SignupController());
    return Scaffold(
      appBar: CustomAppBar(
        title: "signup".tr,
        hasLeading: true,
        textColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "create_account".tr,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
              SizedBox(height: 10.h),
              Text(
                "fill_details".tr,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[700],
                    ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: GestureDetector(
                  onTap: controller.pickImage,
                  child: Obx(
                    () => CircleAvatar(
                      radius: 50.w,
                      backgroundImage: controller.selectedImage.value != null
                          ? FileImage(controller.selectedImage.value!)
                          : null,
                      child: controller.selectedImage.value == null
                          ? Icon(Icons.camera_alt,
                              size: 50.w, color: Colors.grey)
                          : null,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              CustomTextField(
                controller: controller.firstNameController,
                hintText: "first_name".tr,
                icon: Icon(Icons.person, color: Colors.grey),
              ),
              SizedBox(height: 20.h),
              CustomTextField(
                controller: controller.lastNameController,
                hintText: "last_name".tr,
                icon: Icon(Icons.person_outline, color: Colors.grey),
              ),
              SizedBox(height: 20.h),
              CustomTextField(
                controller: controller.phoneController,
                hintText: "phone".tr,
                keyboardType: TextInputType.phone,
                icon: Icon(Icons.phone, color: Colors.grey),
              ),
              SizedBox(height: 20.h),
              CustomTextField(
                controller: controller.locationController,
                hintText: "location".tr,
                icon: Icon(Icons.location_on, color: Colors.grey),
              ),
              SizedBox(height: 20.h),
              StatefulBuilder(builder: (context, setState) {
                return CustomTextField(
                  obscure: obscure,
                  controller: controller.passwordController,
                  hintText: "password".tr,
                  keyboardType: TextInputType.visiblePassword,
                  icon: Icon(Icons.lock, color: Colors.grey),
                  maxLines: 1,
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
              SizedBox(height: 20.h),
              StatefulBuilder(builder: (context, setState) {
                return CustomTextField(
                  controller: controller.confirmPasswordController,
                  hintText: "confirm_password".tr,
                  obscure: obscureConfirm,
                  maxLines: 1,
                  keyboardType: TextInputType.visiblePassword,
                  icon: Icon(Icons.lock_outline, color: Colors.grey),
                  suffix: IconButton(
                    icon: Icon(
                        obscure ? Icons.visibility_off : Icons.visibility,
                        color: obscureConfirm ? null : AppColors.primaryColor),
                    onPressed: () {
                      obscureConfirm = !obscureConfirm;
                      setState(() {});
                    },
                  ),
                );
              }),
              SizedBox(height: 40.h),
              Obx(
                () => controller.status.value == RequestStatus.loading
                    ? CustomButton(
                        title: "signup".tr,
                        onTap: null,
                        loading: true,
                      )
                    : CustomButton(
                        title: "signup".tr,
                        onTap: () {
                          controller.signup();
                        }),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "already_have_account".tr,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      "login".tr,
                      style: TextStyle(color: Theme.of(context).primaryColor),
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

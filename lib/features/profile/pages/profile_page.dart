import 'package:deliveryapp/common/constants/app_colors.dart';
import 'package:deliveryapp/common/constants/end_points.dart';
import 'package:deliveryapp/common/providers/local/cache_provider.dart';
import 'package:deliveryapp/common/routers/app_router.dart';
import 'package:deliveryapp/common/widgets/custom_appbar.dart';
import 'package:deliveryapp/data/enums/request_status.dart';
import 'package:deliveryapp/features/profile/controllers/profile_controller.dart';
import 'package:deliveryapp/features/profile/widgets/language_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
      appBar: CustomAppBar(title: "profile".tr),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() => controller.status.value == RequestStatus.loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                          EndPoints.baseImageUrl + controller.user!.image!,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        controller.user!.firstName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        controller.user!.phone,
                        style: TextStyle(
                          fontSize: 16,
                          // color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  )),
            const SizedBox(height: 24.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  LanguageSwitcher(), // Add the language switcher here
                  const Divider(),
                  ProfileOption(
                    icon: Icons.logout,
                    title: "logout".tr,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("logout".tr),
                          content: Text("are_you_sure_logout".tr),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("cancel".tr),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.offAllNamed(AppRoute.loginPageUrl);
                                CacheProvider.clearAppToken();
                              },
                              child: Text("logout".tr),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileOption({
    required this.icon,
    required this.title,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColors.primaryColor.withOpacity(0.1),
        child: Icon(
          icon,
          color: AppColors.primaryColor,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      onTap: onTap,
    );
  }
}

import 'package:deliveryapp/common/constants/app_colors.dart';
import 'package:deliveryapp/common/routers/app_router.dart';
import 'package:deliveryapp/common/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Profile"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                // Profile Picture
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                    "https://via.placeholder.com/150", // Replace with a valid image URL
                  ),
                ),
                const SizedBox(height: 16.0),
                // User Name
                Text(
                  "John Doe",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 4.0),
                // Email
                Text(
                  "johndoe@example.com",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            // Profile Options
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  ProfileOption(
                    icon: Icons.person_outline,
                    title: "Edit Profile",
                    onTap: () {
                      Get.toNamed(AppRoute.editProfile);
                    },
                  ),
                  const Divider(),
                  ProfileOption(
                    icon: Icons.lock_outline,
                    title: "Change Password",
                    onTap: () {
                      // Handle change password
                    },
                  ),
                  const Divider(),
                  ProfileOption(
                    icon: Icons.notifications_outlined,
                    title: "Notifications",
                    onTap: () {
                      // Handle notifications
                    },
                  ),
                  const Divider(),
                  ProfileOption(
                    icon: Icons.help_outline,
                    title: "Help & Support",
                    onTap: () {
                      // Handle help & support
                    },
                  ),
                  const Divider(),
                  ProfileOption(
                    icon: Icons.logout,
                    title: "Logout",
                    onTap: () {
                      // Handle logout
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Logout"),
                          content:
                              const Text("Are you sure you want to log out?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Cancel"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Perform logout
                                Navigator.pop(context);
                              },
                              child: const Text("Logout"),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
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

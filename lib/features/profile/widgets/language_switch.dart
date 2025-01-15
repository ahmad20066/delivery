import 'package:deliveryapp/common/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> languages = [
      {'code': 'en', 'name': 'English'},
      {'code': 'ar', 'name': 'العربية'},
    ];
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColors.primaryColor.withOpacity(0.1),
        child: Icon(
          Icons.language,
          color: AppColors.primaryColor,
        ),
      ),
      title: Text(
        "Switch Language".tr,
        style: const TextStyle(fontSize: 16),
      ),
      trailing: DropdownButton<String>(
        value: Get.locale?.languageCode ?? 'en',
        items: languages.map((lang) {
          return DropdownMenuItem(
            value: lang['code'],
            child: Text(lang['name']!),
          );
        }).toList(),
        onChanged: (String? value) {
          if (value != null) {
            // Update the app language
            Get.updateLocale(Locale(value));
          }
        },
      ),
    );
  }
}

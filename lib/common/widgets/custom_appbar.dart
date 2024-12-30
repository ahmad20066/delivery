import 'package:deliveryapp/common/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final hasLeading;
  final void Function()? backButtonPressed;
  final Color textColor;
  const CustomAppBar(
      {super.key,
      required this.title,
      this.actions = const [],
      this.hasLeading = false,
      this.backButtonPressed,
      this.textColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: !hasLeading,
      leading: !hasLeading
          ? Container()
          : BackButton(
              color: textColor,
              onPressed: backButtonPressed,
            ),
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
      title: Text(title.tr, style: TextStyle(color: Colors.white)),
      actions: actions,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(80);
}

import 'package:deliveryapp/common/constants/app_colors.dart';
import 'package:deliveryapp/features/main_layout/controller/main_layout_state.dart';
import 'package:deliveryapp/features/main_layout/controller/navbar_controller.dart';
import 'package:deliveryapp/features/main_layout/widgets/navbar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class NavBarWidget extends GetWidget<NavBarController> {
  const NavBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 72.h,
        decoration: const BoxDecoration(
            color: Color.fromRGBO(252, 252, 252, 1),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(56), topRight: Radius.circular(56)),
            boxShadow: [
              BoxShadow(blurRadius: 11, color: Colors.black38),
            ]),
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NavBarItem(
                  icon: Icons.home,
                  title: "home",
                  isSelected: controller.mainState.value == MainLayouState.home,
                  onTap: () {
                    controller.setMainState(MainLayouState.home);
                  }),
              NavBarItem(
                  icon: Icons.favorite,
                  title: "favorites",
                  iconHeight: 26,
                  isSelected:
                      controller.mainState.value == MainLayouState.favorites,
                  onTap: () {
                    // Get.delete<FavoritesController>();
                    // Get.put(FavoritesController());
                    controller.setMainState(MainLayouState.favorites);
                  }),
              NavBarItem(
                  icon: Icons.person,
                  title: "profile",
                  isSelected:
                      controller.mainState.value == MainLayouState.profile,
                  onTap: () {
                    controller.setMainState(MainLayouState.profile);
                  })
            ],
          ),
        ));
  }
}

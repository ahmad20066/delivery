import 'package:deliveryapp/features/home/pages/home_page.dart';
import 'package:deliveryapp/features/main_layout/controller/main_layout_state.dart';
import 'package:deliveryapp/features/main_layout/controller/navbar_controller.dart';
import 'package:deliveryapp/features/main_layout/widgets/navbar.dart';
import 'package:deliveryapp/features/profile/pages/profile_page.dart';
import 'package:deliveryapp/features/wishlist/pages/wishlist_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainLayoutScreen extends StatelessWidget {
  const MainLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavBarController());
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(Icons.add),
      //   backgroundColor: AppColors.primaryColor,
      // ),
      bottomNavigationBar: NavBarWidget(),
      body: Obx(() {
        switch (controller.mainState.value) {
          case MainLayouState.home:
            return HomePage();

          case MainLayouState.profile:
            return ProfilePage();
          // case MainLayouState.pricing:
          //   return PricingPage();
          case MainLayouState.favorites:
            return WishlistPage();
          default:
            return Container();
        }
      }),
    );
  }
}

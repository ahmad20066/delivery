import 'package:deliveryapp/common/routers/app_router.dart';
import 'package:deliveryapp/data/enums/request_status.dart';
import 'package:deliveryapp/features/cart/controllers/cart_controller.dart';
import 'package:deliveryapp/features/home/controllers/home_controller.dart';
import 'package:deliveryapp/features/home/widgets/store_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:deliveryapp/data/models/store_model.dart';
import 'package:deliveryapp/common/widgets/custom_appbar.dart';
import 'package:badges/badges.dart' as badges;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return RefreshIndicator(
      onRefresh: () async {
        await controller.getStores();
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: "home".tr,
          actions: [
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoute.cartPage);
              },
              child: GetBuilder<CartController>(builder: (controller) {
                return badges.Badge(
                  badgeStyle: badges.BadgeStyle(
                    badgeColor: Colors.redAccent,
                  ),
                  badgeContent: Text(
                    controller.cartItems.length
                        .toString(), // Replace with dynamic cart count
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                    size: 30.0,
                  ),
                );
              }),
            ),
            SizedBox(
              width: 20.w,
            )
          ],
        ),
        body: Obx(() {
          if (controller.status.value == RequestStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two items per row
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.75, // Adjusts the height-to-width ratio
                ),
                itemCount: controller.stores.length,
                itemBuilder: (context, index) {
                  final store = controller.stores[index];
                  return StoreCard(store: store);
                },
              ),
            );
          }
        }),
      ),
    );
  }
}

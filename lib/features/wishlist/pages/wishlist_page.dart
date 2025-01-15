import 'package:deliveryapp/common/widgets/custom_appbar.dart';
import 'package:deliveryapp/data/enums/request_status.dart';
import 'package:deliveryapp/features/home/pages/products_page.dart';
import 'package:deliveryapp/features/wishlist/controllers/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WishlistController());
    return Scaffold(
      appBar: CustomAppBar(title: "favorites".tr),
      body: GetBuilder<WishlistController>(builder: (_) {
        // Handle different states of the request
        switch (controller.status.value) {
          case RequestStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case RequestStatus.nodata:
            return const Center(child: Text("No favorites found."));
          case RequestStatus.success:
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.58,
              ),
              itemCount: controller.products.length,
              itemBuilder: (context, index) {
                final product = controller.products[index];
                return ProductCard(
                    product:
                        product); // Use the ProductCard widget to display each product
              },
            );
          case RequestStatus.onerror:
          default:
            return const Center(
                child: Text("An error occurred. Please try again."));
        }
      }),
    );
  }
}

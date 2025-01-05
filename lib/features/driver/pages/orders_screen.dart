import 'package:deliveryapp/common/constants/end_points.dart';
import 'package:deliveryapp/common/providers/local/cache_provider.dart';
import 'package:deliveryapp/common/routers/app_router.dart';
import 'package:deliveryapp/common/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/models/product_model.dart';
import '../controllers/orders_controller.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrdersController ordersController = Get.put(OrdersController());

    return Scaffold(
      appBar: CustomAppBar(
        title: "Driver",
        actions: [
          IconButton(
              onPressed: () {
                Get.offAllNamed(AppRoute.loginPageUrl);
                CacheProvider.clearAppToken();
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      body: Obx(() {
        if (ordersController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (ordersController.orders.isEmpty) {
          return const Center(
            child: Text(
              "No orders yet!",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: ordersController.orders.length,
          itemBuilder: (context, index) {
            final ProductModel product = ordersController.orders[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: SizedBox(
                  width: 60.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      EndPoints.baseImageUrl + product.image,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  product.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.grey),
                ),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    ordersController.updateOrderStatus(product.id, value);
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: "Delivering",
                      child: Text("Mark as Pending"),
                    ),
                    const PopupMenuItem(
                      value: "Done",
                      child: Text("Mark as Done"),
                    ),
                  ],
                  icon: const Icon(Icons.more_vert),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

import 'package:deliveryapp/common/constants/end_points.dart';
import 'package:deliveryapp/common/widgets/custom_appbar.dart';
import 'package:deliveryapp/common/widgets/custom_button.dart';
import 'package:deliveryapp/data/enums/request_status.dart';
import 'package:deliveryapp/features/cart/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());

    return Scaffold(
      appBar: CustomAppBar(
        title: "Cart",
        hasLeading: true,
        textColor: Colors.white,
      ),
      body: Obx(() {
        switch (controller.status.value) {
          case RequestStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case RequestStatus.nodata:
            return Center(child: Text("cart_empty".tr));
          case RequestStatus.onerror:
            return Center(child: Text("failed_to_load_cart".tr));
          case RequestStatus.success:
            return GetBuilder<CartController>(builder: (context) {
              // Calculate total price considering quantity
              double totalPrice = controller.cartItems.fold(
                0,
                (sum, item) => sum + (double.parse(item.price) * item.amount),
              );
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.cartItems.length,
                        itemBuilder: (context, index) {
                          final item = controller.cartItems[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 16.0),
                            elevation: 3.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  EndPoints.baseImageUrl + item.image,
                                  height: 50.0,
                                  width: 50.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                item.name,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${"price".tr}: \$${item.price.toString()}",
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () {
                                          if (item.amount > 1) {
                                            controller.updateQuantity(
                                                item.id, item.amount - 1);
                                          } else {
                                            controller.removeFromCart(item.id);
                                          }
                                        },
                                      ),
                                      GetBuilder<CartController>(builder: (_) {
                                        return Text(
                                          "${item.amount}",
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      }),
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () {
                                          controller.updateQuantity(
                                              item.id, item.amount + 1);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  controller.removeFromCart(item.id);
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const Divider(thickness: 1.5),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "total".tr,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "\$${totalPrice.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          )
                        ],
                      ),
                    ),
                    Obx(() => CustomButton(
                          loading: controller.checkoutStatus.value ==
                              RequestStatus.loading,
                          title: "checkout".tr,
                          onTap: () {
                            controller.checkout();
                          },
                        ))
                  ],
                ),
              );
            });
          default:
            return Container();
        }
      }),
    );
  }
}

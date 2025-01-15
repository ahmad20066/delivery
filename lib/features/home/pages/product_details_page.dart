import 'package:deliveryapp/common/routers/app_router.dart';
import 'package:deliveryapp/common/widgets/custom_appbar.dart';
import 'package:deliveryapp/features/cart/controllers/cart_controller.dart';
import 'package:deliveryapp/features/home/controllers/product_details_controller.dart';
import 'package:deliveryapp/features/main_layout/controller/main_layout_state.dart';
import 'package:deliveryapp/features/main_layout/controller/navbar_controller.dart';
import 'package:deliveryapp/features/wishlist/controllers/wishlist_controller.dart';
import 'package:deliveryapp/features/wishlist/pages/wishlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductDetailsController());
    final product = controller.product;

    return Scaffold(
      appBar: CustomAppBar(
        title: product!.name,
        textColor: Colors.white,
        hasLeading: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Product Image
                Container(
                  height: 300.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(24.0),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(product.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                GetBuilder<WishlistController>(builder: (_) {
                  return Positioned(
                    top: 16.h,
                    right: 16.w,
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.8),
                      child: IconButton(
                        icon: Icon(
                            !Get.find<WishlistController>().isFavorite(product)
                                ? Icons.favorite_border
                                : Icons.favorite,
                            color: Colors.red),
                        onPressed: () {
                          Get.find<WishlistController>()
                              .toggleFavorite(product);
                        },
                      ),
                    ),
                  );
                }),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  // Product Price
                  Text(
                    "\$${product.price}",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Product Description
                  Text(
                    product.description,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[800],
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text(
                      //   "${product.amount} in stock",
                      //   style: TextStyle(
                      //     fontSize: 14.sp,
                      //     color: Colors.grey,
                      //   ),
                      // ),
                      ElevatedButton.icon(
                        onPressed: () {
                          showQuantityDialog(context, product.name, (quantity) {
                            // Add to cart logic with selected quantity
                            Get.find<CartController>()
                                .addToCart(product.id, quantity);
                          });
                        },
                        icon: const Icon(Icons.shopping_cart_outlined),
                        label: Text("add_to_cart".tr),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "key_features".tr,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: [
                      Chip(
                        label: Text(
                          "high_quality".tr,
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        backgroundColor: Colors.purple[50],
                      ),
                      Chip(
                        label: Text(
                          "affordable_price".tr,
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        backgroundColor: Colors.purple[50],
                      ),
                      Chip(
                        label: Text(
                          "best_seller".tr,
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        backgroundColor: Colors.purple[50],
                      ),
                      Chip(
                        label: Text(
                          "fast_delivery".tr,
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        backgroundColor: Colors.purple[50],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton.extended(
              onPressed: () {
                Get.toNamed(AppRoute.cartPage);
              },
              label: Text(
                "cart".tr,
                style: TextStyle(color: Colors.white),
              ),
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
              ),
              backgroundColor: Colors.green,
            ),
            FloatingActionButton.extended(
              onPressed: () {
                Get.back();
                Get.back();
                Get.find<NavBarController>()
                    .mainState(MainLayouState.favorites);
              },
              label: Text(
                "favorites".tr,
                style: TextStyle(color: Colors.white),
              ),
              icon: const Icon(
                Icons.favorite_outline,
                color: Colors.white,
              ),
              backgroundColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

void showQuantityDialog(
  BuildContext context,
  String productName,
  Function(int) onConfirm,
) {
  int selectedQuantity = 1;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("${"select_quantity_for".tr}$productName"),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                if (selectedQuantity > 1) {
                  selectedQuantity--;
                  (context as Element).markNeedsBuild();
                }
              },
            ),
            Text(
              "$selectedQuantity",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                selectedQuantity++;
                (context as Element).markNeedsBuild();
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("cancel".tr),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirm(selectedQuantity);
            },
            child: Text("confirm".tr),
          ),
        ],
      );
    },
  );
}

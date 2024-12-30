import 'package:deliveryapp/common/widgets/custom_appbar.dart';
import 'package:deliveryapp/features/home/controllers/product_details_controller.dart';
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
                // Favorite Button
                Positioned(
                  top: 16.h,
                  right: 16.w,
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.8),
                    child: IconButton(
                      icon:
                          const Icon(Icons.favorite_border, color: Colors.red),
                      onPressed: () {
                        Get.snackbar(
                            "Favorites", "${product.name} added to favorites",
                            snackPosition: SnackPosition.BOTTOM);
                      },
                    ),
                  ),
                ),
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
                      Text(
                        "${product.amount} in stock",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Get.snackbar("Cart", "${product.name} added to cart",
                              snackPosition: SnackPosition.BOTTOM);
                        },
                        icon: const Icon(Icons.shopping_cart_outlined),
                        label: const Text("Add to Cart"),
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
                    "Key Features",
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
                          "High Quality",
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        backgroundColor: Colors.purple[50],
                      ),
                      Chip(
                        label: Text(
                          "Affordable Price",
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        backgroundColor: Colors.purple[50],
                      ),
                      Chip(
                        label: Text(
                          "Best Seller",
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        backgroundColor: Colors.purple[50],
                      ),
                      Chip(
                        label: Text(
                          "Fast Delivery",
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
      // Bottom Cart & Favorites Buttons
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Cart Button
            FloatingActionButton.extended(
              onPressed: () {
                Get.snackbar("Cart", "View your cart",
                    snackPosition: SnackPosition.BOTTOM);
              },
              label: const Text(
                "Cart",
                style: TextStyle(color: Colors.white),
              ),
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
              ),
              backgroundColor: Colors.green,
            ),
            // Favorites Button
            FloatingActionButton.extended(
              onPressed: () {
                Get.snackbar("Favorites", "View your favorites",
                    snackPosition: SnackPosition.BOTTOM);
              },
              label: const Text(
                "Favorites",
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

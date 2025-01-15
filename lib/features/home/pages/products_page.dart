import 'package:badges/badges.dart' as badges;
import 'package:deliveryapp/common/constants/end_points.dart';
import 'package:deliveryapp/common/routers/app_router.dart';
import 'package:deliveryapp/common/widgets/custom_appbar.dart';
import 'package:deliveryapp/data/models/product_model.dart';
import 'package:deliveryapp/features/cart/controllers/cart_controller.dart';
import 'package:deliveryapp/features/home/controllers/products_controller.dart';
import 'package:deliveryapp/features/home/pages/product_details_page.dart';
import 'package:deliveryapp/features/main_layout/controller/main_layout_state.dart';
import 'package:deliveryapp/features/main_layout/controller/navbar_controller.dart';
import 'package:deliveryapp/features/wishlist/controllers/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductsController());
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: CustomAppBar(
        title: controller.store!.name,
        textColor: Colors.white,
        hasLeading: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) => controller.searchProducts(value),
              decoration: InputDecoration(
                hintText: 'search'.tr,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => GridView.builder(
                padding: const EdgeInsets.all(16.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.58,
                ),
                itemCount: controller.filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = controller.filteredProducts[index];
                  return ProductCard(product: product);
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(horizontal: 70.w),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10.0,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          height: 60.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
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
                      controller.cartItems.length.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.green,
                      size: 30.0,
                    ),
                  );
                }),
              ),
              GetBuilder<WishlistController>(builder: (wController) {
                return GestureDetector(
                  onTap: () {
                    Get.back();
                    Get.find<NavBarController>().mainState.value =
                        MainLayouState.favorites;
                  },
                  child: badges.Badge(
                    badgeStyle: badges.BadgeStyle(
                      badgeColor: Colors.redAccent,
                    ),
                    badgeContent: Text(
                      wController.products.length.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Icon(
                      Icons.favorite_outline,
                      color: Colors.red,
                      size: 30.0,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoute.productDetails, arguments: product);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12.0)),
                  child: Image.network(
                    EndPoints.baseImageUrl + product.image,
                    fit: BoxFit.cover,
                    height: 150.0,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  top: 8.0,
                  right: 8.0,
                  child: GetBuilder<WishlistController>(builder: (controller) {
                    return CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.9),
                      child: IconButton(
                        icon: Icon(
                          controller.isFavorite(product)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          controller.toggleFavorite(product);
                        },
                      ),
                    );
                  }),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${product.price}",
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        "${product.amount} in stock",
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  GetBuilder<CartController>(builder: (_) {
                    return Align(
                      alignment: Alignment.center,
                      child: IconButton(
                        onPressed:
                            Get.find<CartController>().isInCart(product.id)
                                ? () {
                                    Get.find<CartController>()
                                        .removeFromCart(product.id);
                                  }
                                : () {
                                    showQuantityDialog(context, product.name,
                                        (quantity) {
                                      // Add to cart logic with selected quantity
                                      Get.find<CartController>()
                                          .addToCart(product.id, quantity);
                                    });
                                  },
                        icon: Icon(
                          Get.find<CartController>().isInCart(product.id)
                              ? Icons.shopping_cart
                              : Icons.shopping_cart_outlined,
                          color: Colors.green,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

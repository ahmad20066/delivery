import 'package:deliveryapp/common/routers/app_router.dart';
import 'package:deliveryapp/common/utils/custom_toasts.dart';
import 'package:deliveryapp/data/enums/request_status.dart';
import 'package:deliveryapp/data/models/app_response.dart';
import 'package:deliveryapp/data/models/product_model.dart';
import 'package:deliveryapp/data/repositories/api_repo.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  Rx<RequestStatus> status = RequestStatus.begin.obs;
  Rx<RequestStatus> checkoutStatus = RequestStatus.begin.obs;
  List<ProductModel> cartItems = [];
  ApiRepo repo = ApiRepo();

  Future<void> fetchCart() async {
    status(RequestStatus.loading);
    AppResponse response = await repo.getCart();
    if (response.success) {
      cartItems = (response.data as List)
          .map((item) => ProductModel.fromMap(item))
          .toList();
      if (cartItems.isEmpty) {
        status(RequestStatus.nodata);
      } else {
        status(RequestStatus.success);
      }
      update();
    } else {
      status(RequestStatus.onerror);
      Get.snackbar("Error", response.errorMessage ?? "An error occurred");
    }
  }

  void updateQuantity(int productId, int newAmount) {
    final index = cartItems.indexWhere((item) => item.id == productId);
    if (index != -1) {
      cartItems[index].amount = newAmount;
      update();
    }
  }

  Future<void> addToCart(int productId, int quantity) async {
    AppResponse response = await repo.addToCart([
      {"product_id": productId, "quantity": quantity}
    ]);
    if (response.success) {
      fetchCart();
      update();
    } else {
      Get.snackbar("Error", response.errorMessage ?? "An error occurred");
    }
  }

  Future<void> checkout() async {
    checkoutStatus(RequestStatus.loading);
    final list = cartItems
        .map((e) => {"product_id": e.id, "quantity": e.amount})
        .toList();
    AppResponse response = await repo.checkout(list);
    if (response.success) {
      // cartItems.clear();
      checkoutStatus(RequestStatus.success);
      Get.offAllNamed(AppRoute.main);
      clearCart();
      CustomToasts.SuccessDialog("Order Placed successfully");
      update();
    } else {
      Get.snackbar("Error", response.errorMessage ?? "An error occurred");
      checkoutStatus(RequestStatus.onerror);
    }
  }

  Future<void> removeFromCart(int productId) async {
    final product = cartItems.firstWhereOrNull((item) => item.id == productId);

    if (product != null) {
      cartItems.remove(product);
      update();
    } else {
      Get.snackbar("Error", "Product not found in the cart");
    }
    final appResponse = await repo.deleteCartItem(productId);
    if (appResponse.success) {
      CustomToasts.SuccessDialog("Item removed successfully");
    } else {
      CustomToasts.ErrorDialog(
          appResponse.errorMessage ?? "Failed to remove item");
    }
  }

  Future<void> clearCart() async {
    print("aaaaa");
    if (cartItems.isEmpty) {
      Get.snackbar("Info", "Cart is already empty");
      return;
    }

    final items = cartItems.map((e) => {"product_id": e.id}).toList();

    AppResponse response = await repo.clearCart(items);
    if (response.success) {
      cartItems.clear();
      // CustomToasts.SuccessDialog("Cart cleared successfully");
      update();
    } else {
      CustomToasts.ErrorDialog(response.errorMessage ?? "Failed to clear cart");
    }
  }

  bool isInCart(int productId) {
    return cartItems.any((product) => product.id == productId);
  }

  @override
  void onInit() {
    fetchCart();
    super.onInit();
  }
}

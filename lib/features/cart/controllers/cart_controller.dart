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

  Future<void> addToCart(int productId) async {
    AppResponse response = await repo.addToCart([
      {"product_id": productId, "quantity": 1}
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
    final list = cartItems.map((e) => {"product_id": e.id}).toList();
    AppResponse response = await repo.checkout(list);
    if (response.success) {
      cartItems.clear();
      checkoutStatus(RequestStatus.success);
      Get.offAllNamed(AppRoute.main);
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
    } else {
      CustomToasts.ErrorDialog(appResponse.errorMessage!);
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

import 'package:deliveryapp/data/repositories/api_repo.dart';
import 'package:get/get.dart';
import '../../../data/models/product_model.dart';

class OrdersController extends GetxController {
  var orders = <ProductModel>[].obs;
  var isLoading = false.obs;
  ApiRepo repo = ApiRepo();

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    isLoading.value = true;
    final response = await repo.getDriverOrders();
    if (response.success && response.data != null) {
      orders.value = (response.data as List)
          .map((order) => ProductModel.fromMap(order))
          .toList();
    } else {
      Get.snackbar("Error", response.errorMessage ?? "Failed to load orders");
    }
    isLoading.value = false;
  }

  Future<void> updateOrderStatus(int orderId, String status) async {
    final response = await repo.changeStatus(orderId, status);
    if (response.success) {
      fetchOrders(); // Refresh orders after status change
      Get.snackbar("Success", "Order status updated successfully");
    } else {
      Get.snackbar("Error", response.errorMessage ?? "Failed to update status");
    }
  }
}

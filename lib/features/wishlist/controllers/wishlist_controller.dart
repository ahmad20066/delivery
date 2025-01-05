import 'package:deliveryapp/data/enums/request_status.dart';
import 'package:deliveryapp/data/models/app_response.dart';
import 'package:deliveryapp/data/models/product_model.dart';
import 'package:deliveryapp/data/repositories/api_repo.dart';
import 'package:get/get.dart';

class WishlistController extends GetxController {
  List<ProductModel> products = [];
  ApiRepo repo = ApiRepo();
  Rx<RequestStatus> status = RequestStatus.begin.obs;
  Future<void> fetchWishlist() async {
    status(RequestStatus.loading);
    AppResponse response = await repo.getFavorites();
    if (response.success) {
      print(response.data);
      products = (response.data as List)
          .map((item) => ProductModel.fromMap(item['product']))
          .toList();
      if (products.isEmpty) {
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

  Future<void> toggleFavorite(ProductModel product) async {
    AppResponse? response;
    if (products.any((e) => product.id == e.id)) {
      products.remove(product);
      if (products.isEmpty) {
        status(RequestStatus.nodata);
      }
      update();
      response = await repo.deleteFavorite(product.id);
    } else {
      products.add(product);
      status(RequestStatus.success);
      update();
      response = await repo.toggleFavorite(product.id);
    }

    if (response.success) {
      update();
    } else {
      Get.snackbar("Error", response.errorMessage ?? "An error occurred");
    }
  }

  bool isFavorite(ProductModel product) {
    return products.contains(product);
  }

  @override
  void onInit() {
    fetchWishlist();
    super.onInit();
  }
}

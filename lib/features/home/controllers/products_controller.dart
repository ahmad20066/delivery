import 'package:deliveryapp/data/models/product_model.dart';
import 'package:deliveryapp/data/models/store_model.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  List<ProductModel> products = [];
  RxList<ProductModel> filteredProducts = <ProductModel>[].obs;
  StoreModel? store;

  @override
  void onInit() {
    store = Get.arguments;
    products = store!.products;
    filteredProducts.addAll(products); // Initialize with all products
    super.onInit();
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      filteredProducts.assignAll(products);
    } else {
      filteredProducts.assignAll(
        products.where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase())),
      );
    }
  }
}

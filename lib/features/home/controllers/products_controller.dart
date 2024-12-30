import 'package:deliveryapp/data/models/product_model.dart';
import 'package:deliveryapp/data/models/store_model.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  List<ProductModel> products = [];
  StoreModel? store;
  @override
  void onInit() {
    store = Get.arguments;
    products = store!.products;
    super.onInit();
  }
}

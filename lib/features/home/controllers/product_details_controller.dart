import 'package:deliveryapp/data/models/product_model.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  ProductModel? product;
  @override
  void onInit() {
    product = Get.arguments;
    super.onInit();
  }
}

import 'package:deliveryapp/common/providers/local/cache_provider.dart';
import 'package:deliveryapp/common/routers/app_router.dart';
import 'package:deliveryapp/features/cart/controllers/cart_controller.dart';
import 'package:deliveryapp/features/wishlist/controllers/wishlist_controller.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(Duration(seconds: 4)).then((e) {
      print(CacheProvider.getAppToken());
      if (CacheProvider.getAppToken() != null) {
        Get.offAllNamed(AppRoute.main);
      } else {
        Get.offAllNamed(AppRoute.loginPageUrl);
      }
    });

    super.onInit();
  }
}

import 'package:deliveryapp/features/auth/pages/login_page.dart';
import 'package:deliveryapp/features/auth/pages/signup_page.dart';
import 'package:deliveryapp/features/cart/pages/cart_page.dart';
import 'package:deliveryapp/features/home/pages/product_details_page.dart';
import 'package:deliveryapp/features/home/pages/products_page.dart';
import 'package:deliveryapp/features/main_layout/screen/main_layout_screen.dart';
import 'package:deliveryapp/features/profile/pages/edit_profile.dart';
import 'package:get/get.dart';

class AppRoute {
  static const homePageUrl = "/home";
  static const main = "/main";
  static const loginPageUrl = "/login-page";
  static const signupPageUrl = '/signup';
  static const productsPage = '/products';
  static const productDetails = '/product-details';
  static const editProfile = '/edit-profile';
  static const cartPage = '/cart';

  static List<GetPage> pages = [
    GetPage(name: loginPageUrl, page: () => LoginPage()),
    GetPage(name: signupPageUrl, page: () => SignupPage()),
    GetPage(name: main, page: () => MainLayoutScreen()),
    GetPage(name: productsPage, page: () => ProductsPage()),
    GetPage(name: productDetails, page: () => ProductDetailsPage()),
    GetPage(name: editProfile, page: () => EditProfile()),
    GetPage(name: cartPage, page: () => CartPage()),
  ];
}

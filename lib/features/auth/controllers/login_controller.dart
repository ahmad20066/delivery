import 'package:deliveryapp/common/providers/local/cache_provider.dart';
import 'package:deliveryapp/common/routers/app_router.dart';
import 'package:deliveryapp/common/utils/custom_toasts.dart';
import 'package:deliveryapp/data/enums/request_status.dart';
import 'package:deliveryapp/data/repositories/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class LoginController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Rx<RequestStatus> status = RequestStatus.begin.obs;
  final AuthRepo _repo = AuthRepo();
  login() async {
    status(RequestStatus.loading);
    final appResponse = await _repo.login(
        {"phone": phoneController.text, "password": passwordController.text});
    if (appResponse.success) {
      print(appResponse.data);
      status(RequestStatus.success);
      await CacheProvider.setAppToken(appResponse.data['token']);
      final role = appResponse.data['user']['role'];
      if (role == 'driver') {
        Get.offAllNamed(AppRoute.driver);
      } else {
        Get.offAllNamed(AppRoute.main);
      }
    } else {
      status(RequestStatus.onerror);
      CustomToasts.ErrorDialog(appResponse.errorMessage!);
    }
  }
}

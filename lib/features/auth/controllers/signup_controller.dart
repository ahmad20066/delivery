import 'package:deliveryapp/common/providers/local/cache_provider.dart';
import 'package:deliveryapp/common/routers/app_router.dart';
import 'package:deliveryapp/common/utils/custom_toasts.dart';
import 'package:deliveryapp/data/enums/request_status.dart';
import 'package:deliveryapp/data/models/user_model.dart';
import 'package:deliveryapp/data/repositories/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';

class SignupController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  Rx<File?> selectedImage = Rx<File?>(null);
  Rx<RequestStatus> status = RequestStatus.begin.obs;
  final AuthRepo _repo = AuthRepo();

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  signup() async {
    status(RequestStatus.loading);

    final user = UserModel(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      location: locationController.text,
      password: passwordController.text,
      password_confirmation: confirmPasswordController.text,
      phone: phoneController.text,
      image: selectedImage.value!, // Pass the selected image
    );

    final appResponse = await _repo.register(user);
    if (appResponse.success) {
      status(RequestStatus.success);
      CacheProvider.setAppToken(appResponse.data['token']);
      Get.offAllNamed(AppRoute.main);
    } else {
      status(RequestStatus.onerror);
      CustomToasts.ErrorDialog(appResponse.errorMessage!);
    }
  }
}

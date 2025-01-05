import 'package:deliveryapp/data/enums/request_status.dart';
import 'package:deliveryapp/data/models/app_response.dart';
import 'package:deliveryapp/data/models/user_model.dart';
import 'package:deliveryapp/data/repositories/api_repo.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  UserModel? user;
  ApiRepo repo = ApiRepo();
  Rx<RequestStatus> status = RequestStatus.begin.obs;
  getProfile() async {
    status(RequestStatus.loading);
    final AppResponse appResponse = await repo.getProfile();
    if (appResponse.success) {
      user = UserModel.fromMap(appResponse.data['user']);
      status(RequestStatus.success);
    } else {
      status(RequestStatus.onerror);
    }
  }

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }
}

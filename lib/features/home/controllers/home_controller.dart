import 'package:deliveryapp/common/utils/custom_toasts.dart';
import 'package:deliveryapp/data/enums/request_status.dart';
import 'package:deliveryapp/data/models/store_model.dart';
import 'package:deliveryapp/data/repositories/api_repo.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  List<StoreModel> stores = [];
  RxList<StoreModel> filteredStores = <StoreModel>[].obs;
  Rx<RequestStatus> status = RequestStatus.begin.obs;
  final ApiRepo _repo = ApiRepo();

  @override
  void onInit() {
    getStores();
    super.onInit();
  }

  getStores() async {
    status(RequestStatus.loading);
    final appResponse = await _repo.getStores();
    if (appResponse.success) {
      stores =
          (appResponse.data as List).map((e) => StoreModel.fromMap(e)).toList();
      filteredStores.assignAll(stores); // Initialize with all stores
      status(RequestStatus.success);
    } else {
      status(RequestStatus.onerror);
      CustomToasts.ErrorDialog(appResponse.errorMessage!);
    }
  }

  void searchStores(String query) {
    if (query.isEmpty) {
      filteredStores.assignAll(stores);
    } else {
      filteredStores.assignAll(
        stores.where(
            (store) => store.name.toLowerCase().contains(query.toLowerCase())),
      );
    }
  }
}

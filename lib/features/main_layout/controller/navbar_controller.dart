import 'package:deliveryapp/features/main_layout/controller/main_layout_state.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class NavBarController extends GetxController {
  Rx<MainLayouState> mainState = MainLayouState.home.obs;
  setMainState(MainLayouState state) => mainState.value = state;

  @override
  void onInit() {
    super.onInit();
  }
}

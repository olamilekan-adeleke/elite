import 'package:elite/cores/utils/emums.dart';
import 'package:elite/cores/utils/snack_bar_service.dart';
import 'package:elite/features/auth/model/user_details_model.dart';
import 'package:elite/features/auth/services/auth_services.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static final AuthenticationRepo authenticationRepo =
      Get.find<AuthenticationRepo>();
  final Rx<ControllerState> controllerState = ControllerState.init.obs;
  Rx<UserDetailsModel>? userDetailsModel;

  Future<void> getUserData() async {
    try {
      controllerState.value = ControllerState.busy;
      final Map<String, dynamic> userData =
          await authenticationRepo.getLoggedInUser();

      userDetailsModel =
          Rx<UserDetailsModel>(UserDetailsModel.fromMap(userData));

      controllerState.value = ControllerState.success;
    } catch (e) {
      controllerState.value = ControllerState.error;
      showErrorSnackBar(e.toString());
    }
  }

  @override
  void onReady() {
    getUserData();
    super.onReady();
  }
}

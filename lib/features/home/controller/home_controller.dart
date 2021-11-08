import '../../../cores/utils/emums.dart';
import '../../../cores/utils/local_database_repo.dart';
import '../../../cores/utils/snack_bar_service.dart';
import '../../auth/model/user_details_model.dart';
import '../../auth/services/auth_services.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/instance_manager.dart';

class HomeController extends GetxController {
  static final AuthenticationRepo authenticationRepo =
      Get.find<AuthenticationRepo>();
  final Rx<ControllerState> _state = ControllerState.init.obs;
  RxString fullname = ''.obs;

  ControllerState get state => _state.value;

  Future<void> getFullName() async {
    _state.value = ControllerState.busy;
    try {
      final Map<String, dynamic> userData =
          await authenticationRepo.getLoggedInUser();

      final UserDetailsModel userDetails = UserDetailsModel.fromMap(userData);

      fullname.value = userDetails.fullName;

      _state.value = ControllerState.success;
    } catch (e) {
      CustomSnackBarService.showErrorSnackBar('Error', e.toString());
      _state.value = ControllerState.error;
    }
  }

  @override
  void onReady() {
    getFullName();
    super.onReady();
  }
}

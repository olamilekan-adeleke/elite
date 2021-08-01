import 'dart:developer';

import 'package:elite/cores/utils/emums.dart';
import 'package:elite/features/auth/model/login_user_model.dart';
import 'package:elite/features/auth/services/auth_services.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AuthStateController extends GetxController {
  static final AuthenticationRepo authenticationRepo =
      Get.find<AuthenticationRepo>();
  final Rx<AuthStateEnum> authStateEnum = AuthStateEnum.loggedOut.obs;

  @override
  void onInit() {
    super.onInit();
    authenticationRepo.userAuthState.listen((LoginUserModel? loginUser) {
      if (loginUser != null) {
        authStateEnum.value = AuthStateEnum.loggedIn;
      } else {
        authStateEnum.value = AuthStateEnum.loggedOut;
      }
    });
  }
}

import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/instance_manager.dart';

import '../../../cores/constants/error_text.dart';
import '../../../cores/utils/emums.dart';
import '../../../cores/utils/logger.dart';
import '../../../cores/utils/navigator_service.dart';
import '../../../cores/utils/snack_bar_service.dart';
import '../services/auth_services.dart';

class RegisterController extends GetxController {
  final Rx<ControllerStateEnum> _controllerStateEnum =
      ControllerStateEnum.init.obs;
  static final AuthenticationRepo _authenticationRepo =
      Get.find<AuthenticationRepo>();
  final TextEditingController firstnameController =
      TextEditingController(text: '');
  final TextEditingController lastnameController =
      TextEditingController(text: '');
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController usernameController =
      TextEditingController(text: '');
  final TextEditingController phoneController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');
  final TextEditingController confirmPasswordController =
      TextEditingController(text: '');

  ControllerStateEnum get controllerStateEnum => _controllerStateEnum.value;

  Future<void> registerUser() async {
    _controllerStateEnum.value = ControllerStateEnum.busy;

    try {
      await _authenticationRepo.registerUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        fullName: '${firstnameController.text.trim()}'
            ' ${lastnameController.text.trim()}',
        number: int.parse(phoneController.text.trim()),
        username: usernameController.text.trim(),
      );
      _controllerStateEnum.value = ControllerStateEnum.success;
      NavigationService.goBack();
      CustomSnackBarService.showSuccessSnackBar(
        'Success',
        'Account Successfully Created!',
      );
    } on SocketException {
      _controllerStateEnum.value = ControllerStateEnum.error;
      CustomSnackBarService.showErrorSnackBar(
          'Error', noInternetConnectionText);
    } catch (e, s) {
      errorLog('$e', 'Error siging up in user', title: 'sign up', trace: '$s');

      _controllerStateEnum.value = ControllerStateEnum.error;
      CustomSnackBarService.showErrorSnackBar('Error', e.toString());
    }
  }
}

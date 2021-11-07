import 'dart:io';

import '../../../cores/constants/error_text.dart';
import '../../../cores/utils/emums.dart';
import '../../../cores/utils/logger.dart';
import '../../../cores/utils/snack_bar_service.dart';
import '../services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/instance_manager.dart';

class LoginControllers extends GetxController {
  final Rx<ControllerStateEnum> _controllerStateEnum =
      ControllerStateEnum.init.obs;
  static final AuthenticationRepo _authenticationRepo =
      Get.find<AuthenticationRepo>();
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');

  ControllerStateEnum get controllerStateEnum => _controllerStateEnum.value;

  Future<void> loginUser() async {
    _controllerStateEnum.value = ControllerStateEnum.busy;
    try {
      await _authenticationRepo.loginUserWithEmailAndPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      _controllerStateEnum.value = ControllerStateEnum.success;
      CustomSnackBarService.showSuccessSnackBar('Success', 'Login Successful!');
    } on SocketException {
      _controllerStateEnum.value = ControllerStateEnum.error;
      CustomSnackBarService.showErrorSnackBar(
          'Error', noInternetConnectionText);
    } catch (e, s) {
      errorLog('$e', 'Error loging in user', title: 'login', trace: '$s');
      _controllerStateEnum.value = ControllerStateEnum.error;
      CustomSnackBarService.showErrorSnackBar('Error', e.toString());
    }
  }
}

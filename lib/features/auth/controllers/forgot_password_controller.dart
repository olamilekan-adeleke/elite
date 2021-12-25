import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/instance_manager.dart';

import '../../../cores/constants/error_text.dart';
import '../../../cores/constants/success_text.dart';
import '../../../cores/utils/emums.dart';
import '../../../cores/utils/logger.dart';
import '../../../cores/utils/snack_bar_service.dart';
import '../services/auth_services.dart';

class ForgotPasswordController extends GetxController {
  final Rx<ControllerState> _controllerStateEnum =
      ControllerState.init.obs;
  static final AuthenticationRepo _authenticationRepo =
      Get.find<AuthenticationRepo>();
  final TextEditingController emailController = TextEditingController(text: '');

  ControllerState get controllerStateEnum => _controllerStateEnum.value;

  Future<void> sendEmail() async {
    _controllerStateEnum.value = ControllerState.busy;
    try {
      await _authenticationRepo.resetPassword(emailController.text.trim());
      _controllerStateEnum.value = ControllerState.success;
      CustomSnackBarService.showSuccessSnackBar(
          'Success', forgotPasswordSucessMessage);
    } on SocketException {
      _controllerStateEnum.value = ControllerState.error;
      CustomSnackBarService.showErrorSnackBar(
          'Error', noInternetConnectionText);
    } catch (e, s) {
      errorLog('$e', 'Error loging in user', title: 'login', trace: '$s');
      _controllerStateEnum.value = ControllerState.error;
      CustomSnackBarService.showErrorSnackBar('Error', e.toString());
    }
  }
}

import 'dart:io';

import 'package:elite/cores/constants/error_text.dart';
import 'package:elite/cores/constants/success_text.dart';
import 'package:elite/cores/utils/emums.dart';
import 'package:elite/cores/utils/logger.dart';
import 'package:elite/cores/utils/snack_bar_service.dart';
import 'package:elite/features/auth/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/instance_manager.dart';

class ForgotPasswordController extends GetxController {
  final Rx<ControllerStateEnum> _controllerStateEnum =
      ControllerStateEnum.init.obs;
  static final AuthenticationRepo _authenticationRepo =
      Get.find<AuthenticationRepo>();
  final TextEditingController emailController = TextEditingController(text: '');

  ControllerStateEnum get controllerStateEnum => _controllerStateEnum.value;

  Future<void> sendEmail() async {
    _controllerStateEnum.value = ControllerStateEnum.busy;
    try {
      await _authenticationRepo.resetPassword(emailController.text.trim());
      _controllerStateEnum.value = ControllerStateEnum.success;
      CustomSnackBarService.showSuccessSnackBar(
          'Success', forgotPasswordSucessMessage);
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

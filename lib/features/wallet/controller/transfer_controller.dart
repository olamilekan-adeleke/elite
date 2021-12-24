import 'package:elite/cores/utils/emums.dart';
import 'package:elite/cores/utils/snack_bar_service.dart';
import 'package:elite/features/wallet/services/transfer_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransferController extends GetxController {
  static final TransferServices transferServices = TransferServices();
  final Rx<String> type = 'Cash'.obs;
  final Rx<String> receivedAs = 'Cash'.obs;
  final Rx<ControllerState> state = ControllerState.init.obs;
  final TextEditingController amountController =
      TextEditingController(text: '');
  final TextEditingController pinController = TextEditingController(text: '');
  final TextEditingController usernameController =
      TextEditingController(text: '');
  final List<String> typeList = <String>['Cash', 'Coin'];

  void send() {
    // turn type to lower case
  }

  void proceed() {
    if (amountController.text.isEmpty) {
      return showWarningSnackBar('Amount cannot be empty!');
    }

    if (pinController.text.isEmpty) {
      return showWarningSnackBar('Please Enter Your Wallet Pin!');
    }

    if (usernameController.text.isEmpty) {
      return showWarningSnackBar('Please Enter Receiver Username!');
    }

    // send request to backend and backend return user details

    Get.toNamed('/confirm-transfer');
  }

  void showPopUp() {}

  void updateType(String? val) {
    if (val == null) return;

    type.value = val;
  }

  void updateReceivedAs(String? val) {
    if (val == null) return;

    receivedAs.value = val;
  }

  void clearData() {
    amountController.clear();
    pinController.clear();
    usernameController.clear();
    type.value = 'Cash';
    receivedAs.value = 'Cash';
  }
}

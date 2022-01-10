import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../cores/utils/emums.dart';
import '../../../cores/utils/snack_bar_service.dart';
import '../../auth/services/auth_services.dart';
import '../model/transaction_model.dart';
import '../services/wallet_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletController extends GetxController {
  static final AuthenticationRepo authenticationRepo =
      Get.find<AuthenticationRepo>();
  final TextEditingController amountController =
      TextEditingController(text: '');
  final TextEditingController pinController = TextEditingController(text: '');
  final Rx<ControllerState> fundWalletState = ControllerState.init.obs;

  Future<void> fundWallet({
    
    required String reference,
  }) async {
    try {
      fundWalletState.value = ControllerState.busy;

      TransactionModel transaction = TransactionModel(
        amount: int.parse(amountController.text),
        description: 'You Funded Your Wallet',
        status: TransactionStatus.pending,
        type: TransactionType.fundWallet,
        timestamp: Timestamp.now().microsecondsSinceEpoch,
        senderId: authenticationRepo.getUserUid(),
      );

      await WalletService().fundWallet(transaction, reference: reference);

      fundWalletState.value = ControllerState.success;

      Get.back();


      await Future<dynamic>.delayed(const Duration(milliseconds: 200));

      showSuccessSnackBar('Payment SuccessFull!');
    } catch (e, s) {
      log(e.toString());
      log(s.toString());

      fundWalletState.value = ControllerState.error;

      showErrorSnackBar(e.toString());
    }
  }
}

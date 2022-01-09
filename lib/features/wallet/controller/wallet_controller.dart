import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite/cores/utils/emums.dart';
import 'package:elite/cores/utils/snack_bar_service.dart';
import 'package:elite/features/auth/services/auth_services.dart';
import 'package:elite/features/wallet/model/transaction_model.dart';
import 'package:elite/features/wallet/services/wallet_service.dart';
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
    required int amount,
    required String reference,
  }) async {
    try {
      fundWalletState.value = ControllerState.busy;

      TransactionModel transaction = TransactionModel(
        amount: amount,
        description: 'You Funded Your Wallet',
        status: TransactionStatus.pending,
        type: TransactionType.fundWallet,
        timestamp: Timestamp.now().microsecondsSinceEpoch,
        senderId: authenticationRepo.getUserUid(),
      );

      await WalletService().fundWallet(transaction, reference: reference);

      fundWalletState.value = ControllerState.success;

      showSuccessSnackBar('Payment SuccessFull!');
    } catch (e, s) {
      log(e.toString());
      log(s.toString());

      fundWalletState.value = ControllerState.error;

      showErrorSnackBar(e.toString());
    }
  }
}

import 'package:elite/cores/utils/emums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletController extends GetxController {
  final TextEditingController amountController =
      TextEditingController(text: '');
  final TextEditingController pinController = TextEditingController(text: '');
  final Rx<ControllerState> fundWalletState = ControllerState.init.obs;


  void fundWallet(){
    fundWalletState.value = ControllerState.busy;

    
    
  }

}

import 'dart:convert';
import 'dart:io';

import '../../../cores/constants/keys.dart';
import '../../../cores/utils/config.dart';
import '../../../cores/utils/emums.dart';
import '../controller/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FundWalletService {
  static final WalletController _walletController =
      Get.find<WalletController>();
  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().microsecondsSinceEpoch}';
  }

  Future<String> _createAccessCode(
    String skTest,
    String _getReference,
    String userEmail,
  ) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $skTest'
    };

    Map data = {"amount": 600, "email": userEmail, "reference": _getReference};

    String payload = json.encode(data);
    http.Response response = await http.post(
      Uri.parse('https://api.paystack.co/transaction/initialize'),
      headers: headers,
      body: payload,
    );

    final Map _data = jsonDecode(response.body);
    String accessCode = _data['data']['access_code'];

    return accessCode;
  }

  // Future<void> _verifyOnServer(String reference) async {
  //   String skTest = secretKey;

  //   try {
  //     Map<String, String> headers = {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer $skTest',
  //     };

  //     http.Response response = await http.get(
  //       Uri.parse('https://api.paystack.co/transaction/verify/' + reference),
  //       headers: headers,
  //     );

  //     final Map body = json.decode(response.body);

  //     if (body['data']['status'] == 'success') {
  //       showSuccessSnackBar('Payment SuccessFull!');
  //     } else {
  //       showErrorSnackBar('Error Occurred');
  //     }
  //   } catch (e) {
  //     print(e);
  //     showErrorSnackBar('Error: $e');
  //   }
  // }

  Future chargeCard({
    required int price,
    required BuildContext context,
    required String userEmail,
  }) async {
    _walletController.fundWalletState.value = ControllerState.busy;

    Charge charge = Charge()
      ..amount = (price * 100).toInt()
      ..reference = _getReference()
      ..accessCode = await _createAccessCode(
        secretKey,
        _getReference(),
        userEmail,
      )
      ..email = userEmail;

    CheckoutResponse response = await Config.paystackPlugin.checkout(
      context,
      method: CheckoutMethod.card,
      fullscreen: true,
      charge: charge,
    );

    if (response.status == true) {
      // await _verifyOnServer(response.reference ?? '');
      await _walletController.fundWallet(reference: response.reference ?? '');
    } else {
      print('error');
      _walletController.fundWalletState.value = ControllerState.error;
    }
  }
}

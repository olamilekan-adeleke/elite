import 'dart:convert';
import 'dart:developer';

import 'package:elite/cores/constants/api.dart';
import 'package:elite/features/auth/model/user_details_model.dart';
import 'package:http/http.dart' as http;

class TransferServices {
  Future<UserDetailsModel?> getUserDetails(String username) async {
    try {
      final http.Response response = await http.post(
        Uri.parse('$firebaseBaseUrl/initSendFund'),
        body: <String, dynamic>{'receiver_username': username},
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      final Map<String, dynamic> responseData =
          json.decode(response.body) as Map<String, dynamic>;

      if (responseData['status'] == 'success') {
        return UserDetailsModel.fromMap(
            responseData['data'] as Map<String, dynamic>);
      } else {
        throw responseData['msg'].toString();
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());

      throw e.toString();
    }
  }
}

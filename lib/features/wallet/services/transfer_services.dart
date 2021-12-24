import 'dart:convert';
import 'dart:developer';

import 'package:elite/cores/constants/api.dart';
import 'package:elite/features/auth/model/user_details_model.dart';
import 'package:http/http.dart' as http;

class TransferServices {
  Future<UserDetailsModel?> getUserDetails(String username) async {
    final Map<String, dynamic> body = <String, dynamic>{
      'receiver_username': username
    };
    try {
      final http.Response response = await http.post(
        Uri.parse('$firebaseBaseUrl/initSendFund'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(body),
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

import 'dart:convert';

import 'package:elite/features/auth/model/user_details_model.dart';

class TransactionModel {
  final TransactionType type;
  final int amount;
  final String description;
  final String? senderId;
  final int timestamp;
  final UserDetailsModel? userDetails;

  TransactionModel({
    required this.type,
    required this.amount,
    required this.description,
    required this.timestamp,
    this.senderId,
    this.userDetails,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': TransactionTypeHelper.convertToString(type),
      'amount': amount,
      'description': description,
      'senderId': senderId,
      'timestamp': timestamp,
      'userDetails': userDetails?.toMap(),
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      type: TransactionTypeHelper.fromString(map['type']),
      amount: map['amount']?.toInt() ?? 0,
      description: map['description'] ?? '',
      senderId: map['senderId'],
      timestamp: map['timestamp']?.toInt() ?? 0,
      userDetails: map['userDetails'] != null
          ? UserDetailsModel.fromMap(map['userDetails'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source));
}

enum TransactionType { sendFund, fundWallet, receiveFund }

class TransactionTypeHelper {
  static TransactionType fromString(String string) {
    switch (string) {
      case 'send_fund':
        return TransactionType.sendFund;
      case 'fund_wallet':
        return TransactionType.fundWallet;
      case 'receive_fund':
        return TransactionType.receiveFund;
      default:
        return TransactionType.fundWallet;
    }
  }

  static String convertToString(TransactionType type) {
    switch (type) {
      case TransactionType.sendFund:
        return 'send_fund';
      case TransactionType.fundWallet:
        return 'fund_wallet';
      case TransactionType.receiveFund:
        return 'receive_fund';
      default:
        return 'fund_wallet';
    }
  }
}

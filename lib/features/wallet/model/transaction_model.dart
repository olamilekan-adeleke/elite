import 'dart:convert';

import 'package:elite/features/auth/model/user_details_model.dart';

class TransactionModel {
  final TransactionType type;
  final TransactionStatus status;
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
    required this.status,
    this.senderId,
    this.userDetails,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': TransactionTypeHelper.convertToString(type),
      'status': TransactionStatusHelper.convertToString(status),
      'amount': amount,
      'description': description,
      'sender_id': senderId,
      'timestamp': timestamp,
      'user_details': userDetails?.toMap(),
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      type: TransactionTypeHelper.fromString(map['type']),
      status: TransactionStatusHelper.fromString(map['status']),
      amount: map['amount']?.toInt() ?? 0,
      description: map['description'] ?? '',
      senderId: map['sender_id'],
      timestamp: map['timestamp']?.toInt() ?? 0,
      userDetails: map['user_details'] != null
          ? UserDetailsModel.fromMap(map['user_details'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source));
}

enum TransactionType { sendFund, fundWallet, receiveFund }
enum TransactionStatus { pending, success, failed }

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

class TransactionStatusHelper {
  static TransactionStatus fromString(String string) {
    switch (string) {
      case 'success':
        return TransactionStatus.success;
      case 'pending':
        return TransactionStatus.pending;
      case 'failed':
        return TransactionStatus.failed;
      default:
        return TransactionStatus.pending;
    }
  }

  static String convertToString(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.success:
        return 'success';
      case TransactionStatus.pending:
        return 'pending';
      case TransactionStatus.failed:
        return 'failed';
      default:
        return 'pending';
    }
  }
}

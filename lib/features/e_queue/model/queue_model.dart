import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite/features/auth/model/user_details_model.dart';
import 'package:uuid/uuid.dart';


class QueueModel {
  QueueModel({
    required this.user,
    required this.numberOfSeats,
    required this.isSentNotification,
    this.serialNumber,
    this.timeJoined,
  });

  factory QueueModel.fromMap(Map<String, dynamic> map) {
    return QueueModel(
      user: UserDetailsModel.fromMap(map['user'] as Map<String, dynamic>),
      numberOfSeats: (map['numberOfSeats']?.toInt() ?? 0) as int,
      serialNumber: (map['serialNumber'] ?? 'none') as String,
      isSentNotification: (map['isSentNotification'] ?? false) as bool,
      timeJoined: (map['timeJoined']?.toInt() ?? 0) as int,
    );
  }

  final UserDetailsModel user;
  final int numberOfSeats;
  final String? serialNumber;
  final bool isSentNotification;
  final int? timeJoined;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toMap(),
      'numberOfSeats': numberOfSeats,
      'serialNumber': serialNumber ?? const Uuid().v1(),
      'isSentNotification': isSentNotification,
      'timeJoined': timeJoined ?? Timestamp.now().millisecondsSinceEpoch,
    };
  }

  String toJson() => json.encode(toMap());
}

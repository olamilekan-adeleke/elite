import 'dart:convert';

import 'package:elite/features/auth/model/user_details_model.dart';

class QueueModel {
  QueueModel({
    required this.user,
    required this.numberOfSeats,
    required this.serialNumber,
    required this.isSentNotification,
    required this.timeJoined,
  });

  factory QueueModel.fromMap(Map<String, dynamic> map) {
    return QueueModel(
      user: UserDetailsModel.fromMap(map['user'] as Map<String, dynamic>),
      numberOfSeats: (map['numberOfSeats']?.toInt() ?? 0) as int,
      serialNumber: (map['serialNumber']?.toInt() ?? 0) as int,
      isSentNotification: (map['isSentNotification'] ?? false) as bool,
      timeJoined: (map['timeJoined']?.toInt() ?? 0) as int,
    );
  }

  final UserDetailsModel user;
  final int numberOfSeats;
  final int serialNumber;
  final bool isSentNotification;
  final int timeJoined;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toMap(),
      'numberOfSeats': numberOfSeats,
      'serialNumber': serialNumber,
      'isSentNotification': isSentNotification,
      'timeJoined': timeJoined,
    };
  }

  String toJson() => json.encode(toMap());
}

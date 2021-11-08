import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetailsModel {
  UserDetailsModel({
    required this.uid,
    required this.email,
    required this.fullName,
    required this.username,
    required this.phoneNumber,
    this.profilePicUrl,
    this.dateJoined,
    required this.walletBalance,
  });

  factory UserDetailsModel.fromMap(Map<String, dynamic>? map) {
    return UserDetailsModel(
      uid: map!['uid'] as String,
      email: map['email'] as String,
      username: map['username'] as String,
      fullName: map['full_name'] as String,
      walletBalance: map['wallet_balance'] != null
          ? double.parse(map['wallet_balance'].toString())
          : 0.0,
      phoneNumber: map['phone_number'] as int,
      profilePicUrl: map['profile_pic_url'] != null
          ? map['profile_pic_url'] as String
          : null,
      dateJoined:
          map['date_joined'] != null ? map['date_joined'] as Timestamp : null,
    );
  }

  factory UserDetailsModel.fromJson(String source) =>
      UserDetailsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  final String uid;
  final String email;
  final String fullName;
  final String username;
  final int phoneNumber;
  final String? profilePicUrl;
  final Timestamp? dateJoined;
  final double? walletBalance;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'username': username,
      'full_name': fullName,
      'phone_number': phoneNumber,
      'profile_pic_url': profilePicUrl,
      'date_joined': dateJoined,
      'has_verify_number': false,
    };
  }

  Map<String, dynamic> toMapForLocalDb() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'full_name': fullName,
      'phone_number': phoneNumber,
      'profile_pic_url': profilePicUrl,
    };
  }

  String toJson() => json.encode(toMap());

  UserDetailsModel copyWith({
    String? uid,
    String? email,
    String? fullName,
    String? username,
    int? phoneNumber,
    String? profilePicUrl,
    Timestamp? dateJoined,
    double? walletBalance,
  }) {
    return UserDetailsModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      username: username ?? this.username,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
      dateJoined: dateJoined ?? this.dateJoined,
      walletBalance: walletBalance ?? this.walletBalance,
    );
  }
}

import 'package:elite/features/notification/services/firebase_messaging_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'cores/utils/config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PushNotificationService.initNotification();
  await Config.setUpPaystack();

  runApp(EliteApp());
}

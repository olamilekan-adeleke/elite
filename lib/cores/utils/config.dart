import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:get_storage/get_storage.dart' as storage;

import '../constants/keys.dart';
import '../../features/notification/services/firebase_messaging_utils.dart';

class Config {
  static final PaystackPlugin paystackPlugin = PaystackPlugin();

  /// init local database using get storage.
  static Future<void> setUpHiveLocalDB() async {
    await storage.GetStorage.init('box');
    await PushNotificationService.initNotification();
    await paystackPlugin.initialize(publicKey: publicKey);
  }
}

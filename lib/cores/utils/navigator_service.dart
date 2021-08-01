import 'dart:developer';

import 'package:get/route_manager.dart';

class NavigationService {
  static Future<dynamic>? navigateTo(String routeName, {dynamic argument}) {
    log(routeName);
    return Get.toNamed(routeName, arguments: argument);
  }

  static Future<dynamic>? navigateRecplace(String routeName,
          {dynamic argument}) =>
      Get.offNamed(routeName, arguments: argument);

  static void goBack() => Get.back();

  static Future<dynamic>? popAllAndPlace(String routeName,
          {dynamic argument}) =>
      Get.offAllNamed(routeName, arguments: argument);
}

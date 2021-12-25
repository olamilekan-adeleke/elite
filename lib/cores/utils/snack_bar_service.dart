import 'package:elite/cores/utils/sizer_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackBarService {
  static void showErrorSnackBar(String title, String message,
      {Duration? duration}) {
    Get.snackbar(
      title,
      message,
      duration: duration ?? const Duration(seconds: 3),
      backgroundColor: Colors.red,
      colorText: Colors.white,
      isDismissible: true,
      icon: const Icon(Icons.error, color: Colors.white),
      margin: EdgeInsets.all(sizerSp(10)),
      padding: EdgeInsets.all(sizerSp(10)),
      snackPosition: SnackPosition.TOP,
    );
  }

  static void showSuccessSnackBar(String title, String message,
      {Duration? duration}) {
    Get.snackbar(
      title,
      message,
      duration: duration ?? const Duration(seconds: 3),
      backgroundColor: Colors.green,
      colorText: Colors.white,
      isDismissible: true,
      icon: const Icon(Icons.error, color: Colors.white),
      margin: EdgeInsets.all(sizerSp(10)),
      padding: EdgeInsets.all(sizerSp(10)),
      snackPosition: SnackPosition.TOP,
    );
  }

  static void showWarningSnackBar(String title, String message,
      {Duration? duration}) {
    Get.snackbar(
      title,
      message,
      duration: duration ?? const Duration(seconds: 3),
      backgroundColor: Colors.grey,
      colorText: Colors.white,
      isDismissible: true,
      icon: const Icon(Icons.error, color: Colors.white),
      margin: EdgeInsets.all(sizerSp(10)),
      padding: EdgeInsets.all(sizerSp(10)),
      snackPosition: SnackPosition.TOP,
    );
  }
}

void showErrorSnackBar(String message, {Duration? duration}) {
  Get.snackbar(
    'Error',
    message,
    duration: duration ?? const Duration(seconds: 3),
    backgroundColor: Colors.red,
    colorText: Colors.white,
    isDismissible: true,
    icon: const Icon(Icons.error, color: Colors.white),
    margin: EdgeInsets.all(sizerSp(10)),
    padding: EdgeInsets.all(sizerSp(10)),
    snackPosition: SnackPosition.TOP,
  );
}

void showSuccessSnackBar(String message, {Duration? duration}) {
  Get.snackbar(
    'Success',
    message,
    duration: duration ?? const Duration(seconds: 3),
    backgroundColor: Colors.green,
    colorText: Colors.white,
    isDismissible: true,
    icon: const Icon(Icons.error, color: Colors.white),
    margin: EdgeInsets.all(sizerSp(10)),
    padding: EdgeInsets.all(sizerSp(10)),
    snackPosition: SnackPosition.TOP,
  );
}

void showWarningSnackBar(String message, {Duration? duration}) {
  Get.snackbar(
    'Warning',
    message,
    duration: duration ?? const Duration(seconds: 3),
    backgroundColor: Colors.grey,
    colorText: Colors.white,
    isDismissible: true,
    icon: const Icon(Icons.error, color: Colors.white),
    margin: EdgeInsets.all(sizerSp(10)),
    padding: EdgeInsets.all(sizerSp(10)),
    snackPosition: SnackPosition.TOP,
  );
}

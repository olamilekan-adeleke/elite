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
      dismissDirection: SnackDismissDirection.HORIZONTAL,
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
      dismissDirection: SnackDismissDirection.HORIZONTAL,
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
      dismissDirection: SnackDismissDirection.HORIZONTAL,
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
<<<<<<< HEAD
    'Error',
=======
    '',
>>>>>>> 21d2e7928055e1dd50a62732c1984ad8a9801055
    message,
    duration: duration ?? const Duration(seconds: 3),
    backgroundColor: Colors.red,
    colorText: Colors.white,
    dismissDirection: SnackDismissDirection.HORIZONTAL,
    isDismissible: true,
    icon: const Icon(Icons.error, color: Colors.white),
    margin: EdgeInsets.all(sizerSp(10)),
    padding: EdgeInsets.all(sizerSp(10)),
    snackPosition: SnackPosition.TOP,
  );
}

void showSuccessSnackBar(String message, {Duration? duration}) {
  Get.snackbar(
<<<<<<< HEAD
    'Success',
=======
    '',
>>>>>>> 21d2e7928055e1dd50a62732c1984ad8a9801055
    message,
    duration: duration ?? const Duration(seconds: 3),
    backgroundColor: Colors.green,
    colorText: Colors.white,
    dismissDirection: SnackDismissDirection.HORIZONTAL,
    isDismissible: true,
    icon: const Icon(Icons.error, color: Colors.white),
    margin: EdgeInsets.all(sizerSp(10)),
    padding: EdgeInsets.all(sizerSp(10)),
    snackPosition: SnackPosition.TOP,
  );
}

void showWarningSnackBar(String message, {Duration? duration}) {
  Get.snackbar(
<<<<<<< HEAD
    'Warning',
=======
    '',
>>>>>>> 21d2e7928055e1dd50a62732c1984ad8a9801055
    message,
    duration: duration ?? const Duration(seconds: 3),
    backgroundColor: Colors.grey,
    colorText: Colors.white,
    dismissDirection: SnackDismissDirection.HORIZONTAL,
    isDismissible: true,
    icon: const Icon(Icons.error, color: Colors.white),
    margin: EdgeInsets.all(sizerSp(10)),
    padding: EdgeInsets.all(sizerSp(10)),
    snackPosition: SnackPosition.TOP,
  );
}

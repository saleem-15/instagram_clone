import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CustomSnackBar {
  static showCustomSnackBar({
    String title = 'Done successfully!',
    required String message,
    Color color = Colors.green,
    Duration duration = const Duration(seconds: 3),
    double? blurScreen,
  }) {
    Get.snackbar(
      title.tr,
      message.tr,
      duration: duration,
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      colorText: Colors.white,
      backgroundColor: color,
      icon: const Icon(
        Icons.check_circle,
        color: Colors.white,
      ),
    );
  }

  static showCustomErrorSnackBar({
    String title = 'Error',
    required String message,
    Color color = Colors.redAccent,
    Duration duration = const Duration(seconds: 3),
    double? blurScreen,
  }) {
    Get.snackbar(
      title.tr,
      message.tr,
      duration: duration,
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      colorText: Colors.white,
      backgroundColor: color,
      barBlur: 1,
      icon: const Icon(
        Icons.error,
        color: Colors.white,
      ),
      overlayBlur: blurScreen,
    );
  }

  static showCustomToast({
    String? title,
    required String message,
    Color color = Colors.green,
    Duration duration = const Duration(seconds: 3),
  }) {
    Get.rawSnackbar(
      title: title,
      message: message.tr,
      duration: duration,
      snackStyle: SnackStyle.GROUNDED,
      backgroundColor: color,
      onTap: (snack) {
        Get.closeAllSnackbars();
      },
      //overlayBlur: 0.8,
    );
  }

  static showCustomErrorToast({
    String? title,
    required String message,
    Color color = Colors.redAccent,
    Duration duration = const Duration(seconds: 3),
  }) {
    Get.rawSnackbar(
      title: title,
      message: message.tr,
      duration: duration,
      snackStyle: SnackStyle.GROUNDED,
      backgroundColor: color,
      onTap: (snack) {
        Get.closeAllSnackbars();
      },
      //overlayBlur: 0.8,
    );
  }
}

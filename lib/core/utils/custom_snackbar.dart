import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomSnackBar {
  static void showCustomSnackBar({
    String? title,
    required String message,
    Duration duration = const Duration(seconds: 4),
    double? blurScreen,
    SnackPosition position = SnackPosition.TOP,
  }) {
    Get.rawSnackbar(
      messageText: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.white,
            size: 24.sp,
          ),
          SizedBox(width: 15.w),
          Flexible(
            child: Text(
              message.tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      snackPosition: position,
      backgroundColor: const Color(0xFF262626),
      borderRadius: 12.r,
      margin: EdgeInsets.only(
        top: position == SnackPosition.TOP ? 15.h : 0,
        bottom: position == SnackPosition.BOTTOM ? 40.h : 0,
        left: 20.w,
        right: 20.w,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      duration: duration,
      barBlur: 10,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeIn,
      animationDuration: const Duration(milliseconds: 500),
      isDismissible: true,
      snackStyle: SnackStyle.FLOATING,
    );
  }

  static void showCustomErrorSnackBar({
    String? title,
    required String message,
    Color? color,
    Duration duration = const Duration(seconds: 4),
    double? blurScreen,
    SnackPosition position = SnackPosition.TOP,
  }) {
    Get.rawSnackbar(
      messageText: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.white,
            size: 24.sp,
          ),
          SizedBox(width: 15.w),
          Flexible(
            child: Text(
              message.tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      snackPosition: position,
      backgroundColor: const Color(0xFF262626),
      borderRadius: 12.r,
      margin: EdgeInsets.only(
        top: position == SnackPosition.TOP ? 15.h : 0,
        bottom: position == SnackPosition.BOTTOM ? 40.h : 0,
        left: 20.w,
        right: 20.w,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      duration: duration,
      barBlur: 10,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeIn,
      animationDuration: const Duration(milliseconds: 500),
      isDismissible: true,
      snackStyle: SnackStyle.FLOATING,
    );
  }

  static void showCustomToast({
    String? title,
    required String message,
    Color color = Colors.black,
    Duration duration = const Duration(seconds: 4),
  }) {
    showCustomSnackBar(message: message, duration: duration);
  }

  static void showCustomErrorToast({
    String? title,
    required String message,
    Color color = Colors.black,
    Duration duration = const Duration(seconds: 4),
  }) {
    showCustomErrorSnackBar(message: message, duration: duration);
  }
}

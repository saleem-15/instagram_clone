import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NoItemsFoundWidget extends StatelessWidget {
  final IconData? icon;
  final Widget? customIcon;
  final String title;
  final String message;
  final VoidCallback? onActionPressed;
  final String? actionText;

  const NoItemsFoundWidget({
    super.key,
    this.icon,
    this.customIcon,
    required this.title,
    required this.message,
    this.onActionPressed,
    this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (customIcon != null)
              customIcon!
            else if (icon != null)
              Icon(
                icon,
                size: 80.sp,
                color: Colors.grey[400],
              ),
            SizedBox(height: 20.h),
            Text(
              title.tr,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.sp,
                  ),
            ),
            SizedBox(height: 10.h),
            Text(
              message.tr,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
            ),
            if (onActionPressed != null && actionText != null) ...[
              SizedBox(height: 25.h),
              ElevatedButton(
                onPressed: onActionPressed,
                style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(actionText!.tr),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

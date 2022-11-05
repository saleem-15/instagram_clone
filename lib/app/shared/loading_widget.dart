// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
    this.size = 35,
    this.strokeWidth = 2,
  }) :color = const Color(0xFFBDBDBD), super(key: key);
  /// Colors.grey.shade400 ==  Color(0xFFBDBDBD)

  const LoadingWidget.button({
    Key? key,
    this.size = 25,
    this.strokeWidth = 3,
    this.color = Colors.white,
  }) : super(key: key);

  final double size;
  final double strokeWidth;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.sp,
      height: size.sp,
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: strokeWidth,
      ),
    );
  }
}

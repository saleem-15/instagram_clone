// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
    this.size = 35,
  }) : super(key: key);

  final int size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.sp,
      height: size.sp,
      child: CircularProgressIndicator(
        color: Colors.grey.shade400,
        strokeWidth: 2,
      ),
    );
  }
}

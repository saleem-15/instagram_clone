// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    Key? key,
    // required this.user,
  }) : super(key: key);

  // final User user;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 15.sp,
      backgroundImage: const AssetImage('assets/images/john.jpg'),
    );
  }
}

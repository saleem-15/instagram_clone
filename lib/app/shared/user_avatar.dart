import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 15.sp,
      backgroundImage: const AssetImage('assets/images/john.jpg'),
    );
  }
}

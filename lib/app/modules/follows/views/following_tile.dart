import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/app/shared/user_avatar.dart';
import 'package:instagram_clone/config/theme/light_theme_colors.dart';

class FollowingTile extends GetView {
  const FollowingTile({
    Key? key,
    required this.following,
  }) : super(key: key);
  final User following;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:  UserAvatar(user: following,),
      title: const Text('userName'),
      subtitle: const Text('name'),
      trailing: SizedBox(
        height: 30.sp,
        child: ElevatedButton(
          onPressed: () {},
          child: const Text(
            'Following',
            style: TextStyle(color: LightThemeColors.buttonTextColor),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/app/modules/follows/controllers/followers_controller.dart';
import 'package:instagram_clone/app/shared/user_avatar.dart';
import 'package:instagram_clone/config/theme/light_theme_colors.dart';

import '../../../models/user.dart';

class FollowerTileView extends StatelessWidget {
  const FollowerTileView({
    Key? key,
    required this.follower,
    required this.controller,
  }) : super(key: key);

  final User follower;

  final FollowersController controller;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
      ),
      child: ListTile(
        onTap: () => controller.goToUserProfile(follower),
        leading: UserAvatar(user: follower),
        title: Text(follower.userName),
        subtitle: Text(follower.nickName),
        trailing: SizedBox(
          height: 30.sp,
          child: ElevatedButton(
            onPressed: () {},
            child: const Text(
              'Remove',
              style: TextStyle(color: LightThemeColors.buttonTextColor),
            ),
          ),
        ),
      ),
    );
  }
}

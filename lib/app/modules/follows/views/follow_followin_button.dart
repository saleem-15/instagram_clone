// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/config/theme/light_theme_colors.dart';

class FollowButton extends StatelessWidget {
  FollowButton({
    Key? key,
    required this.user,
    required this.unFollow,
    required this.follow,
  }) : super(key: key) {
    doIFollowHim = RxBool(user.doIFollowHim);
  }

  final User user;
  late final RxBool doIFollowHim;
  final Function(String userId) unFollow;
  final Function(String userId) follow;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.sp,
      width: 100.sp,
      child: Obx(
        () => doIFollowHim.isTrue
            ? ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                      backgroundColor: MaterialStateProperty.all(null),
                    ),
                onPressed: () async {
                  final isSuccess = await unFollow(user.id);
                  if (isSuccess) {
                    doIFollowHim(false);
                  }
                },
                child: const Text(
                  'Following',
                  style: TextStyle(
                    color: LightThemeColors.buttonTextColor,
                  ),
                ),
              )
            : ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                      backgroundColor: MaterialStateProperty.all(LightThemeColors.lighBlue),
                    ),
                onPressed: () async {
                  final isSuccess = await follow(user.id);
                  if (isSuccess) {
                    doIFollowHim(true);
                  }
                },
                child: const Text(
                  'Follow',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
      ),
    );
  }
}

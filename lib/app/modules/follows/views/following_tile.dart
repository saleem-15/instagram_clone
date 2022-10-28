import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/app/modules/follows/controllers/following_controller.dart';
import 'package:instagram_clone/app/shared/user_avatar.dart';
import 'package:instagram_clone/config/theme/light_theme_colors.dart';

class FollowingTile extends GetView<FollowingController> {
  FollowingTile({
    Key? key,
    required this.following,
  }) : super(key: key);
  final User following;

  final RxBool isFollowing = true.obs;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
      ),
      child: ListTile(
        onTap: () => controller.goToUserProfile(following),
        leading: UserAvatar(
          user: following,
        ),
        title: Text(following.userName),
        subtitle: Text(following.nickName),
        trailing: SizedBox(
          height: 30.sp,
          width: 100.sp,
          child: Obx(
            () => ElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                    backgroundColor: MaterialStateProperty.all(isFollowing.isTrue ? null : LightThemeColors.lighBlue),
                  ),
              onPressed: () async {
                final isSuccess = await controller.unFollow(following.id);
                if (isSuccess) {
                  isFollowing(false);
                }
              },
              child: Text(
                isFollowing.isTrue ? 'Following' : 'Follow',
                style: TextStyle(
                  color: isFollowing.isTrue ? LightThemeColors.buttonTextColor : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

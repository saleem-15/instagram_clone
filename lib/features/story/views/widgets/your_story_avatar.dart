import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/features/root/controllers/app_controller.dart';
import 'package:instagram_clone/core/theme/dark_theme_colors.dart';
import 'package:instagram_clone/core/theme/light_theme_colors.dart';
import 'package:instagram_clone/core/theme/my_fonts.dart';

import 'package:instagram_clone/shared/user_avatar.dart';

import 'story_tile.dart';

class YourStoryAvatar extends StatelessWidget {
  const YourStoryAvatar({
    super.key,
    this.onTap,
  });

  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final appController = Get.find<AppController>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          children: [
            Obx(() {
              // Access property to trigger reactive rebuilds securely
              appController.userImage.value;
              final user = appController.myUser;

              return Container(
                padding: EdgeInsets.all(user.isHasNewStory ? 6.sp : 4.sp),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: user.isHasNewStory
                      ? const DecorationImage(
                          image: AssetImage('assets/icons/story_ring.png'),
                        )
                      : null,
                  // Grey border if all user stories are watched
                  border: user.userStories.isNotEmpty && !user.isHasNewStory
                      ? Border.all(
                          color: Colors.grey.shade800,
                          width: 3.sp,
                          style: BorderStyle.solid,
                        )
                      : null,
                ),
                child: UserAvatar.story(
                  user: user,
                  size: STORY_TILE_SIZE,
                  showRingIfHasStory: false,
                ),
              );
            }),
            Positioned(
              bottom: 2.sp,
              right: 2.sp,
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                  width: 18.sp,
                  height: 18.sp,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      width: 2.sp,
                    ),
                    color: Theme.of(context).brightness == Brightness.dark
                        ? DarkThemeColors.authButtonColor
                        : LightThemeColors.lightBlue,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add,
                    size: 13.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 2.sp),
        Text(
          'Your story',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontSize: MyFonts.bodySmallTextSize),
        ),
      ],
    );
  }
}

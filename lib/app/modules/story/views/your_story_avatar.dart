import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app/modules/root/controllers/app_controller.dart';
import 'package:instagram_clone/config/theme/light_theme_colors.dart';
import 'package:instagram_clone/config/theme/my_fonts.dart';

import 'package:instagram_clone/app/shared/user_avatar.dart';

import 'story_tile.dart';

class YourStoryAvatar extends StatelessWidget {
  const YourStoryAvatar({
    super.key,
    this.onTap,
  });

  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final me = Get.find<AppController>().myUser;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          children: [
            UserAvatar.story(
              user: me,
              size: STORY_TILE_SIZE,
              showRingIfHasStory: false,
            ),
            Positioned(
              bottom: 2,
              right: 2,
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
                    color: LightThemeColors.lightBlue,
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
        ).marginOnly(top: 4.sp),
        SizedBox(height: 4.sp),
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

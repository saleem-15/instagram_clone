import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app/modules/root/controllers/app_controller.dart';
import 'package:instagram_clone/config/theme/light_theme_colors.dart';
import 'package:instagram_clone/config/theme/my_fonts.dart';

import 'story_tile.dart';

class YourStoryAvatar extends StatelessWidget {
  const YourStoryAvatar({
    Key? key,
    this.onTap,
  }) : super(key: key);

  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final me = Get.find<AppController>().myUser;

    final ImageProvider userImage = (me.image == null
        ? const AssetImage('assets/images/default_user_image.png')
        : NetworkImage(me.image!)) as ImageProvider;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Stack(
            children: [
              CircleAvatar(
                radius: STORY_TILE_SIZE,
                child: Image(image: userImage),
              ),
              Positioned(
                bottom: -2,
                right: 0,
                child: Container(
                  // margin: const EdgeInsets.all(5.sp),
                  width: 18.sp,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          Theme.of(context).scaffoldBackgroundColor,
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
              )
            ],
          ),
        ).marginOnly(top: 4.sp),
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

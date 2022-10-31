
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_clone/config/theme/light_theme_colors.dart';
import 'package:instagram_clone/config/theme/my_fonts.dart';

class YourStoryAvatar extends StatelessWidget {
  const YourStoryAvatar({
    Key? key,
    required this.storyAvatarSize,
    this.onTap,
  }) : super(key: key);

  final double storyAvatarSize;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Stack(
            children: [
              CircleAvatar(
                radius: storyAvatarSize,
                child: Image.asset('assets/images/default_user_image.png'),
              ),
              Positioned(
                bottom: -2,
                right: 0,
                child: Container(
                  // margin: const EdgeInsets.all(5.sp),
                  width: 18.sp,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      width: 2.sp,
                    ),
                    color: LightThemeColors.lighBlue,
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
        ),
        const SizedBox(
          height: 1,
        ),
        Text(
          'Your story',
          style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: MyFonts.bodySmallTextSize),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/app/routes/app_pages.dart';
import 'package:instagram_clone/config/theme/light_theme_colors.dart';

import '../../../../config/theme/my_fonts.dart';
import '../../../models/user.dart';
import '../controllers/story_controller.dart';

class StoriesView extends GetView<StoriesController> {
  const StoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    final storyAvatarSize = 25.sp;

    return Column(
      children: [
        SizedBox(
          height: 100,
          child: ListView.builder(
            padding: EdgeInsets.only(left: 10.w),
            scrollDirection: Axis.horizontal,
            itemCount: controller.numOfStories + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return YourStoryAvatar(
                  storyAvatarSize: storyAvatarSize,
                  onTap: controller.onMyStoryAvatarPressed,
                );
              }
              return StoryTile(user: controller.stories[index]);
            },
          ),
        )
      ],
    );
  }
}

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

class StoryTile extends StatelessWidget {
  StoryTile({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  bool isWatched = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.STORY);
      },
      child: Padding(
        padding: const EdgeInsets.only(
          right: 10,
          left: 10,
          top: 10,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(2.5),
              decoration: BoxDecoration(
                gradient: isWatched
                    ? null
                    : const LinearGradient(
                        begin: Alignment.topCenter,
                        colors: [
                          Color(0xff515BD4),
                          Color(0xff8134AF),
                          Color(0xffDD2A7B),
                          Color(0xffFEDA77),
                          Color(0xffF58529),
                        ],
                      ),
                shape: BoxShape.circle,
                border: isWatched
                    ? Border.all(
                        color: Colors.grey.shade300,
                        width: 2,
                        style: BorderStyle.solid,
                      )
                    : null,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(user.image ?? 'assets/images/greg.jpg'),
                ).marginAll(3),
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            Text(
              user.userName,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: MyFonts.bodySmallTextSize),
            ),
          ],
        ),
      ),
    );
  }
}

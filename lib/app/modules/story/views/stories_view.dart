import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/stories_controller.dart';
import 'story_tile.dart';
import 'your_story_avatar.dart';

class StoriesView extends GetView<StoriesController> {
  const StoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    final storyAvatarSize = 25.sp;

    return SizedBox(
      height: 80.sp,
      child: Obx(
        () => CustomScrollView(
          scrollDirection: Axis.horizontal,
          slivers: [
            /// your story avatar
            SliverToBoxAdapter(
              child: YourStoryAvatar(
                onTap: controller.onMyStoryAvatarPressed,
              ).paddingOnly(left: 10.w),
            ),

            /// people you follow stories
            if (controller.isLoading.isFalse)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: controller.stories.length,
                  (_, index) => StoryTile(
                    user: controller.stories[index],
                    userIndex: index,
                  ).marginOnly(left: 10.sp),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

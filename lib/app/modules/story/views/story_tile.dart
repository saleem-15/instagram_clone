// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app/modules/story/controllers/stories_controller.dart';

import '../../../../config/theme/my_fonts.dart';
import '../../../models/user.dart';

final STORY_TILE_SIZE = 25.sp;

class StoryTile extends GetView<StoriesController> {
  const StoryTile({
    Key? key,
    required this.user,
    required this.userIndex,
  }) : super(key: key);

  final User user;
  final int userIndex;

  @override
  Widget build(BuildContext context) {
    final ImageProvider userImage = (user.image == null
        ? const AssetImage('assets/images/default_user_image.png')
        : NetworkImage(user.image!)) as ImageProvider;

    return GestureDetector(
      onTap: () => controller.onStoryTilePressed(userIndex),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GetBuilder<StoriesController>(
            assignId: true,
            id: 'story tile ${user.id}',
            builder: (_) => Container(
              padding:
                  EdgeInsets.all(user.isHasNewStory ? 6.sp : 4.sp),

              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: user.isHasNewStory
                    ? const DecorationImage(
                        image:
                            AssetImage('assets/icons/story_ring.png'),
                      )
                    : null,
                border: !user.isHasNewStory
                    ? Border.all(
                        color: Colors.grey.shade300,
                        width: 1.5,
                        style: BorderStyle.solid,
                      )
                    : null,
              ),
              child: CircleAvatar(
                radius: STORY_TILE_SIZE,
                backgroundImage: userImage,
              ),
              // .marginAll(5.sp),
            ),
          ),

          /// username
          Text(
            user.userName,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: MyFonts.bodySmallTextSize,
                ),
          ),
        ],
      ),
    );
  }
}


  // gradient: !user.isHasNewStory
                  //     ? null
                  //     : const LinearGradient(
                  //         begin: Alignment.topCenter,
                  //         colors: [
                  //           Color(0xff515BD4),
                  //           Color(0xff8134AF),
                  //           Color(0xffDD2A7B),
                  //           Color(0xffFEDA77),
                  //           Color(0xffF58529),
                  //         ],
                  //       ),
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/app/modules/story/controllers/stories_controller.dart';

import '../../../../config/theme/my_fonts.dart';
import '../../../models/user.dart';

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
      child: Padding(
        padding: const EdgeInsets.only(
          right: 5,
          left: 5,
          top: 10,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(2.5),
              decoration: BoxDecoration(
                gradient: !user.isHasNewStory
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
                border: !user.isHasNewStory
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
                  backgroundImage: userImage,
                ).marginAll(3),
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            Text(
              user.userName,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: MyFonts.bodySmallTextSize,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app/modules/story/controllers/stories_controller.dart';

import 'package:instagram_clone/app/routes/app_pages.dart';

import '../../../../config/theme/my_fonts.dart';
import '../../../models/user.dart';

class StoryTile extends GetView<StoriesController> {
  StoryTile({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  bool isWatched = false;

  @override
  Widget build(BuildContext context) {
    final ImageProvider backgroundImage = (user.image == null
        ? const AssetImage('assets/images/default_user_image.png')
        : NetworkImage(user.image!)) as ImageProvider;

    return GestureDetector(
      onTap:() =>  controller.onStoryTilePressed(user),
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
                  backgroundImage: backgroundImage,
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

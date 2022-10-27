import 'package:flutter/material.dart';

import 'package:get/get_utils/src/extensions/widget_extensions.dart';

import 'package:instagram_clone/app/models/user.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    Key? key,
    required this.user,
    this.userAvatarSize = 25,
    this.showRingIfHasStory = true,
  }) : super(key: key);

  /// avatar size is with (sp)
  final double userAvatarSize;
  final User user;
  final bool showRingIfHasStory;
  @override
  Widget build(BuildContext context) {
    // log('user avatar ${user.image}');

    final ImageProvider backgroundImage = (user.image == null
        ? const AssetImage('assets/images/default_user_image.png')
        : NetworkImage(user.image!)) as ImageProvider;

    return user.isHasNewStory && !showRingIfHasStory
        ?

        /// with gradient ring
        Container(
            padding: const EdgeInsets.all(2.5),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
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
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: userAvatarSize,
                backgroundImage: backgroundImage,
              ).marginAll(3),
            ),
          )
        :

        /// without gradient ring
        CircleAvatar(
            radius: userAvatarSize,
            backgroundImage: backgroundImage,
          );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';

import 'package:instagram_clone/app/models/user.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    Key? key,
    this.size = 25,
    required this.user,
    this.showRingIfHasStory = true,
    this.onTap,
  }) : super(key: key);

  /// avatar size is with (sp)
  ///
  /// if you want the user avatar in a comment section  then choose (size 18)
  final double size;
  final User user;
  final bool showRingIfHasStory;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    // log('user avatar ${user.image}');

    final ImageProvider backgroundImage = (user.image == null
        ? const AssetImage('assets/images/default_user_image.png')
        : NetworkImage(user.image!)) as ImageProvider;

    return GestureDetector(
      onTap: onTap,
      child: user.isHasNewStory && showRingIfHasStory
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
                  radius: size,
                  backgroundImage: backgroundImage,
                ).marginAll(3),
              ),
            )
          :

          /// without gradient ring
          CircleAvatar(
              radius: size,
              backgroundImage: backgroundImage,
            ),
    );
  }
}

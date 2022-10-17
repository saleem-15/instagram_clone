// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/app/models/user.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    Key? key,
    required this.user,
    this.isFloatingPost = false,
  }) : super(key: key);

  static double userAvatarSize = 12.sp;
  final User user;
  final bool isFloatingPost;
  @override
  Widget build(BuildContext context) {
    return user.isHasNewStory && !isFloatingPost
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
                backgroundImage: (user.image == null
                    ? const AssetImage('assets/images/default_user_image.png')
                    : NetworkImage(user.image!)) as ImageProvider,
              ).marginAll(3),
            ),
          )
        :

        /// without gradient ring
        CircleAvatar(
            radius: userAvatarSize,
            backgroundImage: (user.image == null
                ? const AssetImage('assets/images/default_user_image.png')
                : NetworkImage(user.image!)) as ImageProvider,
          );
  }
}

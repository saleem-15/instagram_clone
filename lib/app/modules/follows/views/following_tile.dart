// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/app/modules/follows/controllers/following_controller.dart';
import 'package:instagram_clone/app/shared/user_avatar.dart';

import 'follow_followin_button.dart';

class FollowingTile extends StatelessWidget {
  const FollowingTile({
    Key? key,
    required this.following,
    required this.controller,
  }) : super(key: key);

  final User following;
  final FollowingController controller;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
      ),
      child: ListTile(
        onTap: () => controller.goToUserProfile(following),
        leading: UserAvatar.follower(
          user: following,
        ),
        title: Text(following.userName),
        subtitle: Text(following.nickName),
        trailing: following.isMe
            ? null
            : FollowButton(
                user: following,
                unFollow: controller.unFollow,
                follow: controller.follow,
              ),
      ),
    );
  }
}

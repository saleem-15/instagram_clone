// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:instagram_clone/app/modules/follows/controllers/followers_controller.dart';
import 'package:instagram_clone/app/modules/follows/views/follow_followin_button.dart';
import 'package:instagram_clone/app/shared/user_avatar.dart';

import '../../../models/user.dart';

class FollowerTileView extends StatelessWidget {
  const FollowerTileView({
    Key? key,
    required this.follower,
    required this.controller,
  }) : super(key: key);

  final User follower;
  final FollowersController controller;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
      ),
      child: ListTile(
        onTap: () => controller.goToUserProfile(follower),
        leading: UserAvatar.follower(user: follower),
        title: Text(follower.userName),
        subtitle: Text(follower.nickName),

        trailing: follower.isMe ? null: FollowButton(
          user: follower,
          unFollow: controller.unFollow,
          follow: controller.follow,
        ),
      ),
    );
  }
}

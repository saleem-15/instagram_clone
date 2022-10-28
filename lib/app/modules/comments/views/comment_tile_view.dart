import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/app/models/comment.dart';
import 'package:instagram_clone/app/modules/comments/controllers/comments_controller.dart';
import 'package:instagram_clone/app/shared/user_avatar.dart';

class CommentTile extends GetView<CommentsController> {
  const CommentTile({
    Key? key,
    required this.comment,
  }) : super(key: key);

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    /// vertical space between account name and comment text
    final verticalSpace = 5.sp;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: UserAvatar(
              user: comment.user,
              size: 18,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => controller.onUserNamePressd(comment.user),
                  child: Text(
                    comment.user.userName,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                SizedBox(
                  height: verticalSpace,
                ),
                Text(
                  comment.text,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

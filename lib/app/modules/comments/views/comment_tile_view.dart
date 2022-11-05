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
          /// user avatar
          SizedBox(
            width: 40.sp,
            child: UserAvatar.comment(
              user: comment.user,
            ).paddingOnly(top: 5),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///username
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => controller.onUserNamePressd(comment.user),
                      child: Text(
                        comment.user.userName,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),

                    /// created at
                    Text(
                      comment.createdAt,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Theme.of(context).disabledColor,
                          ),
                    ),
                  ],
                ),
                SizedBox(
                  height: verticalSpace,
                ),

                ///comments
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

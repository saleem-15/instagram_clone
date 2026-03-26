import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app/models/comment.dart';
import 'package:instagram_clone/app/modules/comments/controllers/comments_controller.dart';
import 'package:instagram_clone/app/shared/animated_love_button.dart';
import 'package:instagram_clone/app/shared/user_avatar.dart';

class CommentTile extends GetView<CommentsController> {
  const CommentTile({
    super.key,
    required this.comment,
    this.isReply = false,
  });

  final Comment comment;
  final bool isReply;

  @override
  Widget build(BuildContext context) {
    /// vertical space between account name and comment text
    final horizontalPadding = isReply ? 10.w : 0.0;
    final avatarSize = isReply ? 30.sp : 40.sp;

    return Padding(
      padding: EdgeInsets.only(left: horizontalPadding, top: 5, bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// user avatar
              SizedBox(
                width: avatarSize,
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
                          onTap: () =>
                              controller.onUserNamePressd(comment.user),
                          child: Text(
                            comment.user.userName,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),

                        /// created at
                        Text(
                          comment.createdAt,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Theme.of(context).disabledColor,
                                    fontSize: 13.sp,
                                  ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.sp,
                    ),

                    ///comments body with mentions highlighted
                    _CommentText(text: comment.text),

                    SizedBox(height: 5.sp),

                    /// Reply button
                    GestureDetector(
                      onTap: () => controller.onReplyPressed(comment),
                      child: Text(
                        'Reply',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context)
                                  .disabledColor
                                  .withValues(alpha: 0.8),
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              GetBuilder<CommentsController>(
                id: 'love_button_${comment.id}',
                builder: (controller) => AnimatedLoveButton(
                  size: 16.sp,
                  isFavorite: comment.isCommentLiked.value,
                  onHeartPressed: () =>
                      controller.onCommentLikePressed(comment),
                  onInitAnimationController: (animationController) {
                    CommentsController.heartAnimationControllers
                        .addAll({comment.id: animationController});
                  },
                ),
              ),
            ],
          ),

          /// View replies link
          Obx(() {
            if (comment.numOfReplies.value > 0 && !isReply) {
              return Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => controller.toggleReplies(comment),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.sp),
                        child: Row(
                          children: [
                            Container(
                              width: 25.w,
                              height: 0.5,
                              color: Theme.of(context)
                                  .disabledColor
                                  .withValues(alpha: 0.1),
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              comment.isRepliesVisible.value
                                  ? 'Hide replies'
                                  : 'View all ${comment.numOfReplies.value} replies',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontSize: 13.sp,
                                    color: Theme.of(context).disabledColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (comment.isRepliesVisible.value)
                      Column(
                        children: comment.replies
                            .map((reply) => CommentTile(
                                  comment: reply,
                                  isReply: true,
                                ))
                            .toList(),
                      ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}

class _CommentText extends StatelessWidget {
  final String text;

  const _CommentText({required this.text});

  @override
  Widget build(BuildContext context) {
    final List<TextSpan> children = [];
    final RegExp mentionRegex = RegExp(r'(@\w+(?: \w+)?)');
    final List<String> parts = text.split(mentionRegex);
    final List<Match> matches = mentionRegex.allMatches(text).toList();

    for (int i = 0; i < parts.length; i++) {
      children.add(TextSpan(
        text: parts[i],
        style: Theme.of(context).textTheme.bodyMedium,
      ));
      if (i < matches.length) {
        children.add(TextSpan(
          text: matches[i].group(0),
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.blue, // Instagram-like blue for mentions
              ),
        ));
      }
    }

    return RichText(
      text: TextSpan(
        children: children,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:instagram_clone/app/shared/user_avatar.dart';
import 'package:instagram_clone/config/theme/my_styles.dart';

import '../controllers/comments_controller.dart';
import 'comment_tile_view.dart';

class CommentsView extends GetView<CommentsController> {
  const CommentsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final horizontalPadding = 10.w;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: Column(
        children: [
          /// post author && post text
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Row(
              children: [
                const UserAvatar(),
                SizedBox(
                  width: 7.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Account Name
                      Text(
                        controller.accountName,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(
                        height: 3.sp,
                      ),

                      /// post
                      Text(
                        controller.postText,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 3.sp,
          ),
          const Divider(
            thickness: .3,
            height: 0,
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              itemCount: controller.comments.length,
              itemBuilder: (context, index) => CommentTile(
                comment: controller.comments[index],
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const Divider(
              height: 0,
            ),
          ),

          ///comment text fieled
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 10.h, top: 5.h),
              child: Row(
                children: [
                  SizedBox(
                    width: 10.w,
                  ),

                  ///My Profile picture
                  const UserAvatar(),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: TextField(
                      focusNode: controller.textFieldFocusNode,
                      controller: controller.addCommentTextController,
                      cursorHeight: 25,
                      decoration: const InputDecoration(
                        hintText: 'Add a comment...',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        filled: false,
                      ),
                      minLines: 1,
                      maxLines: 6,
                    ),
                  ),
                  Obx(
                    () => TextButton(
                      style: MyStyles.getPostCommentButtonStyle(),
                      onPressed: controller.isPostButtonDisabled.isTrue ? null : controller.postComment,
                      child: const Text('Post'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

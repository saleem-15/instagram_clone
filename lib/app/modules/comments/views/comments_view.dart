import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:instagram_clone/app/shared/user_avatar.dart';

import '../controllers/comments_controller.dart';
import 'comment_tile_view.dart';

class CommentsView extends GetView<CommentsController> {
  const CommentsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final horizontalPadding = 10.w;
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        title: const Text(
          'Comments',
          // style: Theme.of(context).textTheme.headlineSmall,
        ),
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
                      Text(controller.accountName),
                      SizedBox(
                        height: 10.sp,
                      ),

                      /// post
                      Text(controller.postText),
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
                      decoration: const InputDecoration.collapsed(hintText: 'Add a comment...'),
                      minLines: 1,
                      maxLines: 6,
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {},
                    child: const Text('Post'),
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
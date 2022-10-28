import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:instagram_clone/app/models/comment.dart';
import 'package:instagram_clone/app/modules/root/controllers/app_controller.dart';
import 'package:instagram_clone/app/shared/loading_widget.dart';
import 'package:instagram_clone/app/shared/user_avatar.dart';
import 'package:instagram_clone/config/theme/my_styles.dart';

import '../controllers/comments_controller.dart';
import 'comment_tile_view.dart';

class CommentsView extends GetView<CommentsController> {
  const CommentsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    /// the user that posted the post
    final postPublisher = controller.post.user;
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
                UserAvatar(
                  user: postPublisher,
                  size: 18,
                ),
                SizedBox(
                  width: 7.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Account Name (username)
                      GestureDetector(
                        onTap: () => controller.onUserNamePressd(postPublisher),
                        child: Text(
                          controller.accountName,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
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
            child: PagedListView<int, Comment>(
              pagingController: controller.pagingController,
              //
              builderDelegate: PagedChildBuilderDelegate(
                itemBuilder: (_, comment, __) => CommentTile(
                  comment: comment,
                ).paddingSymmetric(horizontal: horizontalPadding),
                //
                newPageProgressIndicatorBuilder: (_) => loadingWidget(),
                //
                firstPageProgressIndicatorBuilder: (_) => loadingWidget(),
                //
                noItemsFoundIndicatorBuilder: (context) => noCommentsFoundWidget(context),
                //
                firstPageErrorIndicatorBuilder: (_) => errorWidget(),
                //
                newPageErrorIndicatorBuilder: (_) => errorWidget(),
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
              padding: EdgeInsets.symmetric(vertical: 3.sp),
              child: Row(
                children: [
                  SizedBox(
                    width: 10.w,
                  ),

                  ///My Profile picture
                  UserAvatar(
                    user: Get.find<AppController>().myUser,
                    showRingIfHasStory: false,
                    size: 18,
                  ),

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

  Widget noCommentsFoundWidget(BuildContext context) {
    return Center(
      child: Text(
        'No Comments was Found'.tr,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget loadingWidget() => const Center(
        child: LoadingWidget(),
      );

  Widget errorWidget() => Center(
        child: Text(
          controller.pagingController.error.toString(),
        ),
      );
}

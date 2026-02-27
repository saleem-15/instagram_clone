import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app/models/post.dart';
import 'package:instagram_clone/app/modules/posts/views/post_media.dart';
import 'package:instagram_clone/app/shared/user_avatar.dart';
import 'package:instagram_clone/config/theme/light_theme_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../controllers/post_controller.dart';

// ignore_for_file: public_member_api_docs, sort_ructors_first

class PostView extends GetView<PostsController> {
  PostView({
    Key? key,
    required this.post,
  }) : super(key: key);

  final RxBool isCounterVisible = true.obs;
  final RxBool isAudioIconVisible = false.obs;
  final Post post;

  @override
  Widget build(BuildContext context) {
    // final contr = Get.find<PostsController>(tag: post.id);
    final postPadding = EdgeInsets.only(
      left: 10.w,
      right: 2.w,
      bottom: 3.sp,
    );
    controller.registerPost(post);
    // showContentCounterTemporary();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        /// picture + name of the user who posted the post
        Padding(
          padding: postPadding,
          child: Row(
            children: [
              UserAvatar.comment(
                user: post.user,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(post.user.userName),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
              )
            ],
          ),
        ),
        const Divider(),

        /// Post photos & videos
        Stack(
          children: [
            InteractiveViewer(
              clipBehavior: Clip.none,
              child: PostMedia(
                post: post,
              ),
            ),
          ],
        ),

        /// row of buttons (love ,comment share,save)
        Padding(
          padding: postPadding.copyWith(left: 0),
          child: Stack(
            children: [
              Row(
                children: [
                  GetBuilder<PostsController>(
                    assignId: true,
                    id: '${post.id} love button',
                    builder: (controller) {
                      log('love button of post ${post.id} is built');
                      return IconButton(
                        key: const ValueKey('Love Button'),
                        onPressed: () =>
                            controller.onHeartPressed(post),
                        icon: ElasticIn(
                          controller: (animationController) {
                            PostsController.heartAnimationControllers
                                .addAll(
                                    {post.id: animationController});
                          },
                          child: post.isFavorite
                              ? FaIcon(
                                  FontAwesomeIcons.solidHeart,
                                  color: Colors.red,
                                  size: 20.sp,
                                )
                              : FaIcon(
                                  FontAwesomeIcons.heart,
                                  size: 20.sp,
                                ),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    onPressed: () => controller.comment(post),
                    icon: const FaIcon(
                      FontAwesomeIcons.comment,
                      size: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.send,
                      size: 20,
                    ),
                  ),
                ],
              ),
              if (post.postContents.length > 1)
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: GetBuilder<PostsController>(
                      assignId: true,
                      id: 'selected content index',
                      builder: (controller) {
                        return AnimatedSmoothIndicator(
                          activeIndex:
                              controller.postsIndex[post.id]!,
                          count: post.postContents.length,
                          effect: const ScrollingDotsEffect(
                            activeDotColor:
                                LightThemeColors.authButtonColor,
                            dotWidth: 5,
                            dotHeight: 5,
                            maxVisibleDots: 7,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              Align(
                alignment: Alignment.centerRight,
                child: GetBuilder<PostsController>(
                  assignId: true,
                  id: '${post.id} save button',
                  builder: (controller) {
                    return IconButton(
                      onPressed: () =>
                          controller.onSaveButtonPressed(post),
                      icon: Icon(
                        post.isSaved
                            ? Icons.bookmark_sharp
                            : Icons.bookmark_outline_sharp,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        /// num of likes and comments
        Padding(
          padding: postPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${post.numOfLikes} likes',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(
                height: 4.sp,
              ),
              Text(post.caption),
              if (post.numOfComments != 0)
                GestureDetector(
                  onTap: () => controller.viewPostComments(post),
                  child: Text(
                    'View all ${post.numOfComments} comments',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 13.sp),
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }
}

// Flexible(
//   fit: FlexFit.loose,
//   // height: 350.h,

//   // width: ,
//   // height: 500,
//   child: Container(
//     constraints: BoxConstraints(minHeight: 200, maxHeight: 400.h),
//     // height: 200,
//     child: PageView.builder(
//       scrollBehavior: const ScrollBehavior(),
//       itemCount: 3,
//       itemBuilder: (context, index) {
//         return SizedBox(
//           child: GestureDetector(
//             onTap: () {},
//             child: Image.asset(
//               post.photos![0],
//               fit: BoxFit.none,
//             ),
//           ),
//         );
//       },
//     ),
//   ),
// ),

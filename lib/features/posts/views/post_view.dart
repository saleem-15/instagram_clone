
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/models/post.dart';
import 'package:instagram_clone/features/posts/views/post_media.dart';
import 'package:instagram_clone/shared/user_avatar.dart';
import 'package:instagram_clone/shared/animated_love_button.dart';
import 'package:instagram_clone/core/theme/dark_theme_colors.dart';
import 'package:instagram_clone/core/theme/light_theme_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../controllers/post_controller.dart';

// ignore_for_file: public_member_api_docs, sort_ructors_first

class PostView extends GetView<PostsController> {
  PostView({
    super.key,
    required this.post,
  });

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
                      return AnimatedLoveButton(
                        isFavorite: post.isFavorite,
                        onHeartPressed: () => controller.onHeartPressed(post),
                        onInitAnimationController: (animationController) {
                          PostsController.heartAnimationControllers
                              .addAll({post.id: animationController});
                        },
                      );
                    },
                  ),
                  IconButton(
                    onPressed: () => controller.comment(post),
                    icon: SvgPicture.asset(
                      'assets/icons/comment.svg',
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).iconTheme.color!,
                        BlendMode.srcIn,
                      ),
                      width: 22.sp,
                    ),
                  ),
                  IconButton(
                    onPressed: () => controller.share(post),
                    icon: SvgPicture.asset(
                      'assets/icons/send.svg',
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).iconTheme.color!,
                        BlendMode.srcIn,
                      ),
                      width: 22.sp,
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
                          activeIndex: controller.postsIndex[post.id]!,
                          count: post.postContents.length,
                          effect: ScrollingDotsEffect(
                            activeDotColor:
                                Theme.of(context).brightness == Brightness.dark
                                    ? DarkThemeColors.authButtonColor
                                    : LightThemeColors.authButtonColor,
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
                      onPressed: () => controller.onSaveButtonPressed(post),
                      icon: SvgPicture.asset(
                        post.isSaved
                            ? 'assets/icons/Save (Filled).svg'
                            : 'assets/icons/Save.svg',
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).iconTheme.color!,
                          BlendMode.srcIn,
                        ),
                        width: 22.sp,
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

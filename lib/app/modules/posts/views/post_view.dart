// ignore_for_file: public_member_api_docs, sort_ructors_first

import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/app/models/post.dart';
import 'package:instagram_clone/app/shared/user_avatar.dart';
import 'package:instagram_clone/config/theme/light_theme_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:video_player/video_player.dart';

import '../controllers/post_controller.dart';

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
    showContentCounterTemporary();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        /// picture + name of the user who posted the post
        Padding(
          padding: postPadding,
          child: Row(
            children: [
               UserAvatar(user: post.user,),
              const SizedBox(
                width: 10,
              ),
              Text(post.user.name),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
              )
            ],
          ),
        ),
        const Divider(),
        Stack(
          children: [
            CarouselSlider.builder(
              carouselController: controller.carouselController,
              itemCount: post.postContents.length,
              options: CarouselOptions(
                enableInfiniteScroll: false,
                height: 500,
                onScrolled: (_) => showContentCounterTemporary(),
                onPageChanged: (index, reason) => controller.onImageSlided(post, index, reason),
                viewportFraction: 1,
              ),
              itemBuilder: (context, index, realIndex) {
                return SizedBox(
                  width: 360.w,
                  child: post.postContents[index].isImageFileName
                      ? GestureDetector(
                          onDoubleTap: () {},
                          child: Image.network(
                            post.postContents[index],
                            fit: BoxFit.cover,
                          ),
                        )
                      : FutureBuilder(
                          future: controller.initilizeVideoController(post.postContents[index]),
                          builder: (context, AsyncSnapshot<VideoPlayerController> snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              final videoController = snapshot.data!;
                              return GestureDetector(
                                onTap: () {
                                  controller.onVideoTapped(snapshot.data!, post, index);
                                  showVideoAudioIconTemporary();
                                },
                                child: Stack(children: [
                                  VideoPlayer(videoController),
                                  Obx(
                                    () => isAudioIconVisible.isFalse
                                        ? const SizedBox.shrink()
                                        : GetBuilder<PostsController>(
                                            assignId: true,
                                            id: '${post.id} $index',
                                            builder: (_) {
                                              return AnimatedScale(
                                                duration: const Duration(milliseconds: 300),
                                                scale: 1.2,
                                                child: Center(
                                                  child: Container(
                                                    padding: const EdgeInsets.all(8),
                                                    decoration: const BoxDecoration(
                                                      color: Color(0xff2d2d37),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Icon(
                                                      videoController.value.volume == 1
                                                          ? Icons.volume_up_outlined
                                                          : Icons.volume_off_rounded,
                                                      color: Colors.white.withOpacity(.8),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                  )
                                ]),
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                );
              },
            ),

            /// post Content Counter (number of images/videos of the post)
            Positioned(
              top: 20,
              right: 20,
              child: Obx(
                () => AnimatedOpacity(
                  opacity: isCounterVisible.value ? 1 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: GetBuilder<PostsController>(
                      assignId: true,
                      id: 'selected content index',
                      builder: (_) {
                        return Text(
                          '${controller.postsIndex[post.id]! + 1}/${post.postContents.length}',
                          style: TextStyle(color: Colors.white.withOpacity(.9)),
                        );
                      },
                    ),
                  ),
                ),
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
                      return IconButton(
                        onPressed: () => controller.onHeartPressed(post),
                        // Icons.favorite => if favorite
                        icon: post.isFavorite
                            ? const FaIcon(
                                FontAwesomeIcons.solidHeart,
                                color: Colors.red,
                                size: 20,
                              )
                            : const FaIcon(
                                FontAwesomeIcons.heart,
                                size: 20,
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
                          activeIndex: controller.postsIndex[post.id]!,
                          count: post.postContents.length,
                          effect: const ScrollingDotsEffect(
                            activeDotColor: LightThemeColors.authButtonColor,
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
                      icon: Icon(
                        post.isSaved ? Icons.bookmark_sharp : Icons.bookmark_outline_sharp,
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
                style: Theme.of(context).textTheme.bodyText1,
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
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 13.sp),
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }

  Future<void> showContentCounterTemporary() async {
    isCounterVisible(true);
    await Future.delayed(const Duration(seconds: 7));
    isCounterVisible(false);
  }

  Future<void> showVideoAudioIconTemporary() async {
    isAudioIconVisible(true);
    await Future.delayed(const Duration(seconds: 2));
    isAudioIconVisible(false);
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

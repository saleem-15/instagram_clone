// ignore_for_file: public_member_api_docs, sort_ructors_first

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/app/models/post.dart';
import 'package:instagram_clone/app/modules/home/controllers/post_controller.dart';
import 'package:instagram_clone/app/shared/user_avatar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:video_player/video_player.dart';

class PostView extends GetView<PostController> {
  const PostView({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  // playVideo() async {
  //   await Future.delayed(const Duration(seconds: 2));
  //   await videoController.initialize();
  //   isInitialize(true);
  //   log('init');
  //   videoController.play();
  // }

  @override
  Widget build(BuildContext context) {
    final postPadding = EdgeInsets.only(
      left: 10.w,
      right: 2.w,
      bottom: 3.sp,
    );
    int postContentIndex = 0;
    // playVideo();
    controller.registerPost(post);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: postPadding,
          child: Row(
            children: [
              const UserAvatar(),
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

        /// contents of the post
        // BetterPlayer.network('https://www.fluttercampus.com/video.mp4'),
        // FutureBuilder(
        //   future: Future.delayed(const Duration(seconds: 5)),
        //   // future: _initializeVideoPlayerFuture,
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.done) {
        //       // If the VideoPlayerController has finished initialization, use
        //       // the data it provides to limit the aspect ratio of the video.
        //       return AspectRatio(
        //         aspectRatio: videoController.value.aspectRatio,
        //         // Use the VideoPlayer widget to display the video.
        //         child: VideoPlayer(videoController),
        //       );
        //     } else {
        //       // If the VideoPlayerController is still initializing, show a
        //       // loading spinner.
        //       return const Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }
        //   },
        // ),
        // Obx(
        //   () => isInitialize.value
        //       ? const SizedBox.shrink()
        //       : AspectRatio(
        //           aspectRatio: videoController.value.aspectRatio,
        //           child: VideoPlayer(videoController),
        //         ),
        // ),

        Stack(
          children: [
            CarouselSlider.builder(
              carouselController: controller.carouselController,
              itemCount: post.postContents.length,
              options: CarouselOptions(
                enableInfiniteScroll: false,
                height: 500,
                onPageChanged: (index, reason) => controller.onImageSlided(post, index, reason),
                viewportFraction: 1,
              ),
              itemBuilder: (context, index, realIndex) {
                postContentIndex = index;

                return post.postContents[index].isImageFileName
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
                            return GestureDetector(
                              onTap: () => controller.onVideoTapped(snapshot.data!, post, index),
                              child: Stack(children: [
                                VideoPlayer(snapshot.data!),
                                GetBuilder<PostController>(
                                  builder: (_) {
                                    return const Icon(Icons.volume_up_outlined);
                                  },
                                )
                              ]),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      );
              },
            ),

            /// Counter
            Positioned(
              top: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: GetBuilder<PostController>(
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
          ],
        ),

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

        /// row of buttons (love ,comment share,save)
        Padding(
          padding: postPadding.copyWith(left: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GetBuilder<PostController>(
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
             
              GetBuilder<PostController>(
                assignId: true,
                id: 'selected content index',
                builder: (controller) {
                  return AnimatedSmoothIndicator(
                    activeIndex: controller.postsIndex[post.id]!,
                    count: post.postContents.length,
                    // count: post.photos!.length,
                    effect: const ScrollingDotsEffect(
                      dotWidth: 5,
                      dotHeight: 5,
                      maxVisibleDots: 7,
                    ),
                  );
                },
              ),
              GetBuilder<PostController>(
                assignId: true,
                id: '${post.id} save button',
                builder: (controller) {
                  return IconButton(
                    onPressed: () => controller.onSaveButtonPressed(post),
                    icon: Icon(post.isSaved ? Icons.bookmark_sharp : Icons.bookmark_outline_sharp),
                  );
                },
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
}

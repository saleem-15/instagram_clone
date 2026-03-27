
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/models/post.dart';
import 'package:instagram_clone/core/utils/constants/api.dart';
import 'package:instagram_clone/features/posts/controllers/post_controller.dart';
import 'package:instagram_clone/features/posts/views/animated_heart.dart';
import 'package:instagram_clone/shared/loading_widget.dart';
import 'package:video_player/video_player.dart';


class PostMedia extends GetView<PostsController> {
  PostMedia({
    super.key,
    required this.post,
  });

  final Post post;
  final RxBool isCounterVisible = true.obs;
  final RxBool isAudioIconVisible = false.obs;
  final RxBool isHeartVisible = false.obs;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider.builder(
          carouselController: controller.carouselController,
          itemCount: post.postContents.length,
          options: CarouselOptions(
            enableInfiniteScroll: false,
            height: 500,
            onScrolled: (_) => showContentCounterTemporary(),
            onPageChanged: (index, reason) =>
                controller.onImageSlided(post, index, reason),
            viewportFraction: 1,
          ),
          itemBuilder: (context, index, realIndex) {
            return SizedBox(
              width: 360.w,
              child: post.postContents[index].isImageFileName ||
                      post.postContents.first.endsWith('.webp')
                  ?

                  /// image
                  GestureDetector(
                      onDoubleTap: () =>
                          controller.onPostDoubleTap(post, isHeartVisible),
                      child: CachedNetworkImage(
                        imageUrl: post.postContents[index],
                        httpHeaders: Api.headers,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) {
                          return const Center(
                            child: Icon(Icons.broken_image, color: Colors.grey),
                          );
                        },
                        placeholder: (context, url) {
                          return const Center(
                            child: LoadingWidget(size: 60, strokeWidth: 1.0),
                          );
                        },
                      ),
                    )
                  :

                  /// video
                  FutureBuilder(
                      future: controller
                          .initilizeVideoController(post.postContents[index]),
                      builder: (context,
                          AsyncSnapshot<VideoPlayerController> snapshot) {
                        // Loading State
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: LoadingWidget(size: 60, strokeWidth: 1.0),
                          );
                        }

                        // Error State
                        if (snapshot.hasError) {
                          // Handle the error state (e.g., show a play error icon)

                          return const Center(
                            child: Icon(Icons.error, color: Colors.white),
                          );
                        }

                        if (snapshot.hasData) {
                          final videoController = snapshot.data!;
                          return GestureDetector(
                            onTap: () {
                              controller.onVideoTapped(
                                  snapshot.data!, post, index);
                              showVideoAudioIconTemporary();
                            },
                            onDoubleTap: () => controller.onPostDoubleTap(
                                post, isHeartVisible),
                            child: Stack(children: [
                              Positioned.fill(
                                child: ClipRect(
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: SizedBox(
                                      width: videoController.value.size.width,
                                      height: videoController.value.size.height,
                                      child: VideoPlayer(videoController),
                                    ),
                                  ),
                                ),
                              ),
                              Obx(
                                () => isAudioIconVisible.isFalse
                                    ? const SizedBox.shrink()
                                    : GetBuilder<PostsController>(
                                        assignId: true,
                                        id: '${post.id} $index',
                                        builder: (_) {
                                          return AnimatedScale(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            scale: 1.2,
                                            child: Center(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: const BoxDecoration(
                                                  color: Color(0xff2d2d37),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  videoController
                                                              .value.volume ==
                                                          1
                                                      ? Icons.volume_up_outlined
                                                      : Icons
                                                          .volume_off_rounded,
                                                  color: Colors.white
                                                      .withValues(alpha: .8),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                              )
                            ]),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
            );
          },
        ),

        /// post Content Counter (number of images/videos of the post)
        if (post.postContents.length > 1)
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
                        style: TextStyle(
                            color: Colors.white.withValues(alpha: .9)),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),

        Positioned.fill(
          child: Obx(() {
            if (isHeartVisible.isTrue) {
              return const AnimatedHeart();
            }

            return const SizedBox.shrink();
          }),
        ),
        // Positioned.fill(
        //   child: GetBuilder<PostsController>(
        //     assignId: true,
        //     builder: (_) {
        //       return const Center(
        //         child: AnimatedHeart(),
        //       );
        //     },
        //   ),
        // ),
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

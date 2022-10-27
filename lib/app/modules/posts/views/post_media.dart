import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/utils/constants/api.dart';
import 'package:video_player/video_player.dart';

import 'package:instagram_clone/app/models/post.dart';

import '../controllers/post_controller.dart';

class PostMedia extends GetView<PostsController> {
  PostMedia({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;
  final RxBool isCounterVisible = true.obs;
  final RxBool isAudioIconVisible = false.obs;

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
                        // post.postContents[index],

                        'https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg',
                        headers: Api.headers,
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

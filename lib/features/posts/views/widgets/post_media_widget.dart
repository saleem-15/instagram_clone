import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:instagram_clone/core/utils/my_video_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/models/post.dart';
import 'package:instagram_clone/core/utils/constants/api.dart';
import 'package:instagram_clone/features/posts/controllers/post_controller.dart';
import 'package:instagram_clone/features/posts/views/widgets/animated_heart_widget.dart';
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
                  _PostVideoItem(
                    videoUrl: post.postContents[index],
                    post: post,
                    index: index,
                    postsController: controller,
                    isAudioIconVisible: isAudioIconVisible,
                    isHeartVisible: isHeartVisible,
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

class _PostVideoItem extends StatefulWidget {
  final String videoUrl;
  final Post post;
  final int index;
  final PostsController postsController;
  final RxBool isAudioIconVisible;
  final RxBool isHeartVisible;

  const _PostVideoItem({
    required this.videoUrl,
    required this.post,
    required this.index,
    required this.postsController,
    required this.isAudioIconVisible,
    required this.isHeartVisible,
  });

  @override
  State<_PostVideoItem> createState() => _PostVideoItemState();
}

class _PostVideoItemState extends State<_PostVideoItem> {
  late MyVideoController _myVideoController;

  @override
  void initState() {
    super.initState();
    _myVideoController = MyVideoController(videoUrl: widget.videoUrl);
    _myVideoController.initialize().then((_) {
      _myVideoController.controller?.setVolume(0); // Videos are silent by default
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _myVideoController.disposeVideo();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_myVideoController.isInitialized || _myVideoController.controller == null) {
      return const Center(
        child: LoadingWidget(size: 60, strokeWidth: 1.0),
      );
    }
    
    final videoController = _myVideoController.controller!;
    
    return VisibilityDetector(
      key: Key('post_${widget.post.id}_${widget.index}'),
      onVisibilityChanged: (info) {
        _myVideoController.handleVisibility(info.visibleFraction, onStateChanged: () {
          if (mounted) setState(() {});
        });
      },
      child: GestureDetector(
        onTap: () {
          videoController.setVolume(videoController.value.volume == 0 ? 1 : 0);
          widget.postsController.update(['${widget.post.id} ${widget.index}']);
          
          widget.isAudioIconVisible(true);
          Future.delayed(const Duration(seconds: 2)).then((_){
            widget.isAudioIconVisible(false);
          });
        },
        onDoubleTap: () => widget.postsController.onPostDoubleTap(
            widget.post, widget.isHeartVisible),
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
            () => widget.isAudioIconVisible.isFalse
                ? const SizedBox.shrink()
                : GetBuilder<PostsController>(
                    assignId: true,
                    id: '${widget.post.id} ${widget.index}',
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
                              color: Colors.white.withValues(alpha: .8),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          )
        ]),
      ),
    );
  }
}

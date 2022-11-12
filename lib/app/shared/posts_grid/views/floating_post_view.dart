// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app/modules/posts/controllers/post_controller.dart';
import 'package:instagram_clone/app/shared/posts_grid/controllers/floating_post_controller.dart';
import 'package:video_player/video_player.dart';

import 'package:instagram_clone/app/models/post.dart';
import 'package:instagram_clone/app/shared/user_avatar.dart';

class FloatingPostView extends StatelessWidget {
  const FloatingPostView({
    Key? key,
    required this.post,
    required this.controller,
  }) : super(key: key);
  final Post post;
  final FloatingPostController controller;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 12.0),
      duration: const Duration(milliseconds: 500),
      builder: (_, value, child) {
        log('--------------------------');
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: value, sigmaY: value),
          child: child,
        );
      },
      child: Center(
        child: ScaleTransition(
          scale: controller.animation,
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            child: _PostView(post: post),
          ),
        ),
      ),
    );
  }
}

class _PostView extends GetView<PostsController> {
  _PostView({
    Key? key,
    required this.post,
  }) : super(key: key);

  final RxBool isCounterVisible = true.obs;
  final RxBool isAudioIconVisible = false.obs;
  final Post post;

  @override
  Widget build(BuildContext context) {
    final buttonsRowPadding = EdgeInsets.only(
      left: 10.w,
      right: 10.w,
      top: 3.sp,
      bottom: 3.sp,
    );
    controller.registerPost(post);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        /// picture + name of the user who posted the post
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6.sp, horizontal: 10.w),
          child: Row(
            children: [
              UserAvatar.comment(
                user: post.user,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(post.user.userName),
            ],
          ),
        ),

        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 530.h, maxWidth: 340.w),
          child: Builder(
            builder: (context) {
              if (post.postContents.first.isImageFileName || post.postContents.first.endsWith('.webp')) {
                log('${post.postContents.first} is image');
                return Image.network(
                  post.postContents.first,
                  alignment: Alignment.center,
                  width: 340.w,
                  fit: BoxFit.cover,
                );
              }
              log('${post.postContents.first} is video');
              return FutureBuilder(
                  future: controller.initilizeVideoController(post.postContents.first),
                  builder: (context, AsyncSnapshot<VideoPlayerController> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      final videoController = snapshot.data!;
                      return VideoPlayer(videoController);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  });
            },
          ),
        ),

        /// row of buttons (love ,comment share)
        Padding(
          padding: buttonsRowPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GetBuilder<PostsController>(
                assignId: true,
                id: '${post.id} love button',
                builder: (controller) {
                  return GestureDetector(
                    onTap: () {
                      log('HI---------------------');
                    },
                    onPanStart: (details) {
                      log('HI---------------------');
                    },
                    child: IconButton(
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
        ),
      ],
    );
  }
}

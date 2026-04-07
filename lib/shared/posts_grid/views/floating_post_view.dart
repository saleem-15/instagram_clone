// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/features/posts/controllers/post_controller.dart';
import 'package:instagram_clone/shared/posts_grid/controllers/floating_post_controller.dart';
import 'package:instagram_clone/shared/widgets/app_network_image.dart';
import 'package:instagram_clone/shared/widgets/app_video_player.dart';
import 'package:instagram_clone/core/models/post.dart';
import 'package:instagram_clone/shared/user_avatar.dart';

class FloatingPostView extends StatelessWidget {
  const FloatingPostView({
    super.key,
    required this.post,
    required this.controller,
  });
  final Post post;
  final FloatingPostController controller;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 12.0),
      duration: const Duration(milliseconds: 300),
      builder: (_, value, child) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: value, sigmaY: value),
          child: child,
        );
      },
      child: Center(
        child: ScaleTransition(
          scale: controller.animation,
          child: Dismissible(
            key: Key(post.id),
            direction: DismissDirection.vertical,
            onDismissed: (_) {
              Get.back();
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r)),
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              child: _PostView(post: post),
            ),
          ),
        ),
      ),
    );
  }
}

class _PostView extends GetView<PostsController> {
  _PostView({
    required this.post,
  });

  final RxBool isCounterVisible = true.obs;
  final RxBool isAudioIconVisible = false.obs;
  final Post post;

  @override
  Widget build(BuildContext context) {
    controller.registerPost(post);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader(),
        _buildMedia(context),
        _buildActions(context),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 10.w),
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
    );
  }

  Widget _buildMedia(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height * 0.5;
    final mediaWidth = 340.w;

    if (post.postContents.first.isImageFileName ||
        post.postContents.first.endsWith('.webp')) {
      return AppNetworkImage(
        imageUrl: post.postContents.first,
        width: mediaWidth,
        height: mediaHeight,
        fit: BoxFit.cover,
      );
    }

    return AppVideoPlayer(
      videoUrl: post.postContents.first,
      width: mediaWidth,
      height: mediaHeight,
      isMuted: false,
      isLooping: true,
      showVolumeToggle: true,
    );
  }

  Widget _buildActions(BuildContext context) {
    final buttonsRowPadding = EdgeInsets.only(
      left: 10.w,
      right: 10.w,
      top: 3.sp,
      bottom: 3.sp,
    );

    return Padding(
      padding: buttonsRowPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GetBuilder<PostsController>(
            assignId: true,
            id: '${post.id} love button',
            builder: (controller) {
              return GestureDetector(
                onTap: () {},
                onPanStart: (details) {},
                child: IconButton(
                  onPressed: () => controller.onHeartPressed(post),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: Pulse(
                    duration: const Duration(milliseconds: 300),
                    controller: (animationController) {
                      PostsController.heartAnimationControllers
                          .addAll({post.id: animationController});
                    },
                    child: post.isFavorite
                        ? SvgPicture.asset(
                            'assets/icons/Heart (Filled).svg',
                            colorFilter: const ColorFilter.mode(
                              Colors.red,
                              BlendMode.srcIn,
                            ),
                            width: 20.sp,
                            height: 20.sp,
                          )
                        : SvgPicture.asset(
                            'assets/icons/heart.svg',
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).iconTheme.color ?? Colors.white,
                              BlendMode.srcIn,
                            ),
                            width: 20.sp,
                            height: 20.sp,
                          ),
                  ),
                ),
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
              width: 20.sp,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/icons/send.svg',
              colorFilter: ColorFilter.mode(
                Theme.of(context).iconTheme.color!,
                BlendMode.srcIn,
              ),
              width: 20.sp,
            ),
          ),
        ],
      ),
    );
  }
}

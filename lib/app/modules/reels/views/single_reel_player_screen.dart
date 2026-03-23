import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'package:instagram_clone/app/shared/loading_widget.dart';
import 'package:instagram_clone/app/modules/comments/views/comments_view.dart';
import 'package:instagram_clone/app/shared/user_avatar.dart';
import 'package:instagram_clone/app/shared/animated_love_button.dart';
import '../controllers/single_reel_player_controller.dart';

class SingleReelPlayerScreen extends GetView<SingleReelPlayerController> {
  const SingleReelPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                final isCommentsOpen = controller.isCommentsOpen.value;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  margin: isCommentsOpen
                      ? const EdgeInsets.only(
                          top: 10, left: 10, right: 10, bottom: 10)
                      : EdgeInsets.zero,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(isCommentsOpen ? 25 : 0),
                    color: Colors.black,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: [
                      // Player + Play/Pause logic
                      Positioned.fill(
                        child: Obx(() {
                          if (!controller.isInitialized.value ||
                              controller.videoController == null) {
                            return const Center(child: LoadingWidget());
                          }
                          return GetBuilder<SingleReelPlayerController>(
                            id: 'playback',
                            builder: (c) {
                              final isPlaying =
                                  c.videoController!.value.isPlaying;
                              return GestureDetector(
                                onTap: c.togglePlay,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Center(
                                      child: AspectRatio(
                                        aspectRatio: c
                                            .videoController!.value.aspectRatio,
                                        child: Obx(
                                          () => ClipRRect(
                                              borderRadius:
                                                  BorderRadiusGeometry.circular(
                                                      controller.isCommentsOpen
                                                              .value
                                                          ? 20
                                                          : 0),
                                              child: VideoPlayer(
                                                  c.videoController!)),
                                        ),
                                      ),
                                    ),
                                    if (!isPlaying)
                                      const Center(
                                        child: Icon(
                                          Icons.play_circle_fill,
                                          color: Colors.white60,
                                          size: 80,
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            },
                          );
                        }),
                      ),

                      // Back Button
                      Positioned(
                        top: 40,
                        left: 10,
                        child: Obx(() => IgnorePointer(
                              ignoring: controller.isCommentsOpen.value,
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 300),
                                opacity:
                                    controller.isCommentsOpen.value ? 0.0 : 1.0,
                                child: IconButton(
                                  icon: const Icon(Icons.arrow_back,
                                      color: Colors.white),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ),
                            )),
                      ),

                      // User Info (Bottom Left)
                      Positioned(
                        bottom: 20,
                        right: 15,
                        child: Obx(() => IgnorePointer(
                              ignoring: controller.isCommentsOpen.value,
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 300),
                                opacity:
                                    controller.isCommentsOpen.value ? 0.0 : 1.0,
                                child: GetBuilder<SingleReelPlayerController>(
                                  id: 'user_info',
                                  builder: (c) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            c.reel.user.userName,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          UserAvatar.follower(
                                            user: c.reel.user,
                                            size: 20,
                                          ),
                                          if (!c.reel.user.isMe &&
                                              !c.reel.user.doIFollowHim) ...[
                                            const SizedBox(width: 10),
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 0),
                                                minimumSize: const Size(60, 30),
                                                backgroundColor:
                                                    Colors.transparent,
                                                side: const BorderSide(
                                                    color: Colors.white),
                                              ),
                                              onPressed: c.followUser,
                                              child: const Text('Follow',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                          ]
                                        ],
                                      ),
                                      if (c.reel.caption.isNotEmpty) ...[
                                        const SizedBox(height: 10),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: Text(
                                            c.reel.caption,
                                            style: const TextStyle(
                                                color: Colors.white),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ]
                                    ],
                                  ),
                                ),
                              ),
                            )),
                      ),

                      // Actions Sidebar (Bottom Right)
                      Positioned(
                        bottom: 120,
                        left: 10,
                        child: Obx(() => IgnorePointer(
                              ignoring: controller.isCommentsOpen.value,
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 300),
                                opacity:
                                    controller.isCommentsOpen.value ? 0.0 : 1.0,
                                child: GetBuilder<SingleReelPlayerController>(
                                  id: 'actions',
                                  builder: (c) => Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      // Love Button
                                      AnimatedLoveButton(
                                        isFavorite: c.reel.isFavorite,
                                        size: 28,
                                        onHeartPressed: c.onHeartPressed,
                                      ),
                                      Text(
                                        '${c.reel.numOfLikes}',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      const SizedBox(height: 15),

                                      // Comment Button
                                      IconButton(
                                        icon: const FaIcon(
                                            FontAwesomeIcons.comment,
                                            color: Colors.white,
                                            size: 26),
                                        onPressed: c.comment,
                                      ),
                                      Text(
                                        '${c.reel.numOfComments}',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      const SizedBox(height: 15),

                                      // Send Button
                                      IconButton(
                                        icon: SvgPicture.asset(
                                          'assets/icons/send.svg',
                                          colorFilter: const ColorFilter.mode(
                                            Colors.white,
                                            BlendMode.srcIn,
                                          ),
                                          width: 28.sp,
                                        ),
                                        onPressed: () {},
                                      ),
                                      const SizedBox(height: 15),

                                      // Save Button
                                      IconButton(
                                        icon: Icon(
                                          c.reel.isSaved
                                              ? Icons.bookmark_sharp
                                              : Icons.bookmark_outline_sharp,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                        onPressed: c.onSavePressed,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                      ),
                      // Video Progress Indicator
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Obx(() {
                          if (controller.isInitialized.value &&
                              controller.videoController != null) {
                            return SizedBox(
                              height: 2.sp,
                              width: Get.width,
                              child: VideoProgressIndicator(
                                controller.videoController!,
                                allowScrubbing: true,
                                padding: EdgeInsets.zero,
                                colors: const VideoProgressColors(
                                  playedColor: Colors.white,
                                  bufferedColor: Colors.white10,
                                  backgroundColor: Colors.white10,
                                ),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        }),
                      ),
                    ],
                  ),
                );
              }),
            ),
            // Inline Animated Comments View
            Obx(() {
              final kbHeight = MediaQuery.of(context).viewInsets.bottom;
              final maxCommentsHeight = controller.maxCommentsHeight;
              final maxDragUp = (Get.height * 0.55) - maxCommentsHeight;

              final dragOffset = controller.dragOffset.value;
              final isSnapping = dragOffset == 0.0 || dragOffset == maxDragUp;

              final targetHeight = (Get.height * 0.55 - dragOffset)
                  .clamp(0.0, maxCommentsHeight);

              return AnimatedContainer(
                duration: isSnapping
                    ? const Duration(milliseconds: 300)
                    : Duration.zero,
                curve: Curves.easeOutCubic,
                height: controller.isCommentsOpen.value ? targetHeight : 0,
                child: Padding(
                  padding: EdgeInsets.only(bottom: kbHeight),
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20)),
                    child: Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Column(
                        children: [
                          GestureDetector(
                            onVerticalDragUpdate:
                                controller.onVerticalDragUpdate,
                            onVerticalDragEnd: controller.onVerticalDragEnd,
                            behavior: HitTestBehavior.opaque,
                            child: Column(
                              children: [
                                const SizedBox(height: 12),
                                Container(
                                  width: 40,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    borderRadius: BorderRadius.circular(2.5),
                                  ),
                                ),
                                const SizedBox(height: 12),
                              ],
                            ),
                          ),
                          Expanded(
                              child: controller.isCommentsOpen.value
                                  ? CommentsView()
                                  : const SizedBox.shrink()),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),

            // Comment Text Field at the bottom of the Screen
            Obx(() {
              if (controller.isCommentsOpen.value) {
                return const SizedBox.shrink();
              }
              return Container(
                color: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: TextField(
                  readOnly: true,
                  onTap: controller.comment,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Add a comment...',
                    hintStyle: const TextStyle(color: Colors.white54),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    filled: true,
                    fillColor: Colors.white24,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

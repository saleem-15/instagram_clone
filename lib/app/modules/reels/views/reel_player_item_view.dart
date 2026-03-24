import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'package:instagram_clone/app/models/reel.dart';
import 'package:instagram_clone/app/shared/loading_widget.dart';
import 'package:instagram_clone/app/modules/comments/views/comments_view.dart';
import 'package:instagram_clone/app/shared/user_avatar.dart';
import 'package:instagram_clone/app/shared/animated_love_button.dart';
import '../controllers/reel_player_controller.dart';

class ReelPlayerItemView extends StatefulWidget {
  final Reel reel;
  final bool isCurrentPage;

  const ReelPlayerItemView({
    super.key,
    required this.reel,
    required this.isCurrentPage,
  });

  @override
  State<ReelPlayerItemView> createState() => _ReelPlayerItemViewState();
}

class _ReelPlayerItemViewState extends State<ReelPlayerItemView> {
  late String tag;
  late ReelPlayerController controller;

  @override
  void initState() {
    super.initState();
    tag = '${widget.reel.id}_${UniqueKey().toString()}';
    controller = Get.put(ReelPlayerController(reel: widget.reel), tag: tag);
    if (widget.isCurrentPage) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.playVideo();
      });
    }
  }

  @override
  void dispose() {
    Get.delete<ReelPlayerController>(tag: tag);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ReelPlayerItemView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isCurrentPage != oldWidget.isCurrentPage) {
      if (widget.isCurrentPage) {
        controller.playVideo();
      } else {
        controller.pauseVideo();
        if (controller.isCommentsOpen.value) {
          controller.isCommentsOpen.value = false;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReelPlayerController>(
      tag: tag,
      builder: (c) {
        return Column(
          children: [
            Expanded(
              child: Obx(() {
                final isCommentsOpen = c.isCommentsOpen.value;
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
                          if (!c.isInitialized.value ||
                              c.videoController == null) {
                            return const Center(child: LoadingWidget());
                          }
                          return GetBuilder<ReelPlayerController>(
                            tag: tag,
                            id: 'playback',
                            builder: (cv) {
                              final isPlaying =
                                  cv.videoController!.value.isPlaying;
                              return GestureDetector(
                                onTap: cv.togglePlay,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Center(
                                      child: AspectRatio(
                                        aspectRatio: cv
                                            .videoController!.value.aspectRatio,
                                        child: Obx(
                                          () => ClipRRect(
                                              borderRadius:
                                                  BorderRadiusGeometry.circular(
                                                      c.isCommentsOpen.value
                                                          ? 20
                                                          : 0),
                                              child: VideoPlayer(
                                                  cv.videoController!)),
                                        ),
                                      ),
                                    ),
                                    if (!isPlaying)
                                      Center(
                                        child: Container(
                                          width: 60.sp,
                                          height: 60.sp,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.black
                                                .withValues(alpha: 0.5),
                                          ),
                                          child: Icon(
                                            Icons.play_arrow_rounded,
                                            color: Colors.white,
                                            size: 40.sp,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            },
                          );
                        }),
                      ),

                      // User Info (Bottom Left)
                      Positioned(
                        bottom: 20,
                        right: 15,
                        child: Obx(() => IgnorePointer(
                              ignoring: c.isCommentsOpen.value,
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 300),
                                opacity: c.isCommentsOpen.value ? 0.0 : 1.0,
                                child: GetBuilder<ReelPlayerController>(
                                  tag: tag,
                                  id: 'user_info',
                                  builder: (cv) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            cv.reel.user.userName,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          UserAvatar.follower(
                                            user: cv.reel.user,
                                            size: 20,
                                          ),
                                          if (!cv.reel.user.isMe &&
                                              !cv.reel.user.doIFollowHim) ...[
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
                                              onPressed: cv.followUser,
                                              child: const Text('Follow',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                          ]
                                        ],
                                      ),
                                      if (cv.reel.caption.isNotEmpty) ...[
                                        const SizedBox(height: 10),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: Text(
                                            cv.reel.caption,
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
                        bottom: 130.h,
                        left: 10,
                        child: Obx(() => IgnorePointer(
                              ignoring: c.isCommentsOpen.value,
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 300),
                                opacity: c.isCommentsOpen.value ? 0.0 : 1.0,
                                child: GetBuilder<ReelPlayerController>(
                                  tag: tag,
                                  id: 'actions',
                                  builder: (cv) => Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      // Love Button
                                      AnimatedLoveButton(
                                        isFavorite: cv.reel.isFavorite,
                                        size: 28,
                                        onHeartPressed: cv.onHeartPressed,
                                      ),
                                      Text(
                                        '${cv.reel.numOfLikes}',
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
                                        onPressed: cv.comment,
                                      ),
                                      Text(
                                        '${cv.reel.numOfComments}',
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
                                          cv.reel.isSaved
                                              ? Icons.bookmark_sharp
                                              : Icons.bookmark_outline_sharp,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                        onPressed: cv.onSavePressed,
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
                          if (c.isInitialized.value &&
                              c.videoController != null) {
                            return SizedBox(
                              height: 12.sp,
                              width: Get.width,
                              child: VideoProgressIndicator(
                                c.videoController!,
                                allowScrubbing: true,
                                padding:
                                    EdgeInsets.only(top: 5.sp, bottom: 5.sp),
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
              final maxCommentsHeight = c.maxCommentsHeight;
              final maxDragUp = (Get.height * 0.55) - maxCommentsHeight;

              final dragOffset = c.dragOffset.value;
              final isSnapping = dragOffset == 0.0 || dragOffset == maxDragUp;

              final targetHeight = (Get.height * 0.55 - dragOffset)
                  .clamp(0.0, maxCommentsHeight);

              return AnimatedContainer(
                duration: isSnapping
                    ? const Duration(milliseconds: 300)
                    : Duration.zero,
                curve: Curves.easeOutCubic,
                height: c.isCommentsOpen.value ? targetHeight : 0,
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
                            onVerticalDragUpdate: c.onVerticalDragUpdate,
                            onVerticalDragEnd: c.onVerticalDragEnd,
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
                              child: c.isCommentsOpen.value
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
              if (c.isCommentsOpen.value) {
                return const SizedBox.shrink();
              }
              return Container(
                color: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: TextField(
                  readOnly: true,
                  onTap: c.comment,
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
        );
      },
    );
  }
}

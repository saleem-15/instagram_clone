import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/core/models/reel.dart';
import 'package:instagram_clone/features/comments/views/comments_view.dart';
import '../controllers/reel_player_controller.dart';
import 'widgets/actions_side_bar_widget.dart';
import 'widgets/reel_player_widget.dart';
import 'widgets/reel_progress_indicator_widget.dart';
import 'widgets/user_info_widget.dart';

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
    controller =
        Get.put(ReelPlayerController(reel: widget.reel, tag: tag), tag: tag);
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
      builder: (controller) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final availableHeight = constraints.maxHeight;
            controller.availableHeight.value = availableHeight;
            return Column(
              children: [
                Obx(() {
                  final isCommentsOpen = controller.isCommentsOpen.value;
                  final dragOffset = controller.dragOffset.value;
                  final isFullOpen = dragOffset <= controller.maxDragUp + 10;
                  return Expanded(
                    flex: isFullOpen ? 0 : 1,
                    child: Visibility(
                      visible: !isFullOpen,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutCubic,
                        margin: isCommentsOpen
                            ? const EdgeInsets.only(
                                top: 10, left: 10, right: 10, bottom: 10)
                            : EdgeInsets.zero,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(isCommentsOpen ? 25 : 0),
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          children: [
                            // Player + Play/Pause logic
                            Positioned.fill(
                              child: ReelPlayer(
                                tag: tag,
                                controller: controller,
                              ),
                            ),

                            // User Info (Bottom Left)
                            Positioned(
                              bottom: 60.h,
                              right: 15,
                              child: UserInfoWidget(
                                tag: tag,
                                controller: controller,
                              ),
                            ),

                            // Actions Sidebar (Bottom Right)
                            Positioned(
                              bottom: 190.h,
                              left: 5.w,
                              child: ActionsSideBar(
                                tag: tag,
                                controller: controller,
                              ),
                            ),
                            // Video Progress Indicator
                            Positioned(
                              bottom: 0,
                              child: Visibility(
                                visible: !controller.isCommentsOpen.value,
                                child: ReelProgressIndicator(
                                  controller: controller,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                // Inline Animated Comments View
                Obx(() {
                  final dragOffset = controller.dragOffset.value;
                  final maxDragUp = controller.maxDragUp;
                  final isSnapping =
                      dragOffset == 0.0 || dragOffset == maxDragUp;

                  final targetHeight = (availableHeight * 0.5 - dragOffset)
                      .clamp(0.0, availableHeight);

                  return Flexible(
                    flex: controller.isCommentsOpen.value ? 0 : 0,
                    child: AnimatedContainer(
                      duration: isSnapping
                          ? const Duration(milliseconds: 300)
                          : Duration.zero,
                      curve: Curves.easeOutCubic,
                      height:
                          controller.isCommentsOpen.value ? targetHeight : 0,
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30.r)),
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
                                    const SizedBox(
                                      height: 10,
                                      width: double.infinity,
                                    ),
                                    // handle
                                    Container(
                                      width: 35.w,
                                      height: 2.5.sp,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[400],
                                        borderRadius:
                                            BorderRadius.circular(2.5),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: controller.isCommentsOpen.value
                                    ? CommentsView(tag: tag)
                                    : const SizedBox.shrink(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),

                // Comment Text Field at the bottom of the Screen
                // Obx(() {
                //   if (controller.isCommentsOpen.value) {
                //     return const SizedBox.shrink();
                //   }
                //   return Container(
                //     color: Colors.black,
                //     padding:
                //         const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                //     child: commentField(controller),
                //   );
                // }),
              ],
            );
          },
        );
      },
    );
  }

  TextField commentField(ReelPlayerController controller) {
    return TextField(
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../controllers/reel_player_controller.dart';

class ReelPlayer extends StatelessWidget {
  const ReelPlayer({
    super.key,
    required this.tag,
    required this.controller,
  });

  final String tag;
  final ReelPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReelPlayerController>(
      tag: tag,
      id: 'playback',
      builder: (cv) {
        final myVc = controller.myVideoController;

        // ── Not ready yet → seamless black background (no spinner) ──
        if (!myVc.isInitialized || myVc.controller == null) {
          return Container(color: Colors.black);
        }

        final isPlaying = !myVc.isPaused;

        return VisibilityDetector(
          key: Key('reel_${controller.reel.id}'),
          onVisibilityChanged: (info) {
            myVc.handleVisibility(info.visibleFraction);
          },
          child: GestureDetector(
            onTap: controller.togglePlay,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Center(
                  child: AspectRatio(
                    aspectRatio: myVc.controller!.value.aspectRatio,
                    child: Obx(
                      () => ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(
                              controller.isCommentsOpen.value ? 20 : 0),
                          child: VideoPlayer(myVc.controller!)),
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
                        color: Colors.black.withValues(alpha: 0.1),
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
          ),
        );
      },
    );
  }
}

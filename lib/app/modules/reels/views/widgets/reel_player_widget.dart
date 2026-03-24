import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app/shared/loading_widget.dart';
import 'package:video_player/video_player.dart';

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
    return Obx(() {
      if (!controller.isInitialized.value ||
          controller.videoController == null) {
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
                                  controller.isCommentsOpen
                                          .value
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
    });
  }
}

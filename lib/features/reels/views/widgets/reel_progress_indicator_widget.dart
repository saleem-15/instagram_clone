import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../controllers/reel_player_controller.dart';

class ReelProgressIndicator extends StatelessWidget {
  const ReelProgressIndicator({
    super.key,
    required this.controller,
  });

  final ReelPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isInitialized.value &&
          controller.videoController != null) {
        return SizedBox(
          height: 12.sp,
          width: Get.width,
          child: VideoProgressIndicator(
            controller.videoController!,
            allowScrubbing: true,
            padding: EdgeInsets.only(top: 5.sp, bottom: 5.sp),
            colors: const VideoProgressColors(
              playedColor: Colors.white,
              bufferedColor: Colors.white10,
              backgroundColor: Colors.white10,
            ),
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }
}

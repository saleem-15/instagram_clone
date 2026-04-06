import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/shared/loading_widget.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../controllers/reel_player_controller.dart';

class ReelPlayer extends StatefulWidget {
  const ReelPlayer({
    super.key,
    required this.tag,
    required this.controller,
  });

  final String tag;
  final ReelPlayerController controller;

  @override
  State<ReelPlayer> createState() => _ReelPlayerState();
}

class _ReelPlayerState extends State<ReelPlayer> {
  @override
  void initState() {
    super.initState();
    // Re-render when initialized
    widget.controller.myVideoController.initialize().then((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.controller.myVideoController.isInitialized || widget.controller.myVideoController.controller == null) {
      return const Center(child: LoadingWidget());
    }
    return GetBuilder<ReelPlayerController>(
      tag: widget.tag,
      id: 'playback',
      builder: (cv) {
        final isPlaying = !widget.controller.myVideoController.isPaused;
        return VisibilityDetector(
          key: Key('reel_${widget.controller.reel.id}'),
          onVisibilityChanged: (info) {
            widget.controller.myVideoController.handleVisibility(info.visibleFraction, onStateChanged: () {
              if (mounted) setState(() {});
            });
          },
          child: GestureDetector(
            onTap: () {
              widget.controller.togglePlay();
              setState(() {});
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                Center(
                  child: AspectRatio(
                    aspectRatio: widget.controller.myVideoController.controller!.value.aspectRatio,
                    child: Obx(
                      () => ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(
                              widget.controller.isCommentsOpen.value ? 20 : 0),
                          child: VideoPlayer(widget.controller.myVideoController.controller!)),
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


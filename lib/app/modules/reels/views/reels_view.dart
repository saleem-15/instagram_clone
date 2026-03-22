import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'package:instagram_clone/app/models/reel.dart';
import '../controllers/reels_controller.dart';
import 'package:instagram_clone/app/shared/loading_widget.dart';
import 'package:instagram_clone/app/shared/user_avatar.dart';

class ReelsView extends GetView<ReelsController> {
  const ReelsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: LoadingWidget());
        }
        if (controller.isError.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Error fetching reels',
                    style: TextStyle(color: Colors.white)),
                TextButton(
                  onPressed: controller.fetchReels,
                  child: const Text('Try Again'),
                ),
              ],
            ),
          );
        }
        if (controller.reels.isEmpty) {
          return const Center(
            child: Text(
              'No Reels yet',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          );
        }

        return PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: controller.reels.length,
          itemBuilder: (context, index) {
            final reel = controller.reels[index];
            return ReelPlayerWidget(
              reel: reel,
              controller: controller,
            );
          },
        );
      }),
    );
  }
}

class ReelPlayerWidget extends StatefulWidget {
  final Reel reel;
  final ReelsController controller;

  const ReelPlayerWidget({
    super.key,
    required this.reel,
    required this.controller,
  });

  @override
  State<ReelPlayerWidget> createState() => _ReelPlayerWidgetState();
}

class _ReelPlayerWidgetState extends State<ReelPlayerWidget> {
  VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  Future<void> _initVideo() async {
    _videoController = await widget.controller
        .initilizeVideoController(widget.reel.reelMediaUrl);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Video Player
        Positioned.fill(
          child:
              _videoController != null && _videoController!.value.isInitialized
                  ? GestureDetector(
                      onTap: () {
                        if (_videoController!.value.isPlaying) {
                          _videoController!.pause();
                        } else {
                          _videoController!.play();
                        }
                      },
                      child: AspectRatio(
                        aspectRatio: _videoController!.value.aspectRatio,
                        child: VideoPlayer(_videoController!),
                      ),
                    )
                  : const Center(child: LoadingWidget()),
        ),

        // User Info Overlay
        Positioned(
          bottom: 20,
          left: 15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  UserAvatar.follower(
                    user: widget.reel.user,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.reel.user.userName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),

        // Action Buttons (Delete for owners)
        if (widget.reel.user.isMe)
          Positioned(
            bottom: 20,
            right: 15,
            child: IconButton(
              icon: const Icon(Icons.delete, color: Colors.white),
              onPressed: () {
                widget.controller.deleteReel(widget.reel.id);
              },
            ),
          )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:instagram_clone/app/models/reel.dart';
import 'package:instagram_clone/app/shared/loading_widget.dart';
import 'package:instagram_clone/app/shared/user_avatar.dart';
import '../controllers/single_reel_player_controller.dart';

class SingleReelPlayerScreen extends StatelessWidget {
  final Reel reel;
  const SingleReelPlayerScreen({super.key, required this.reel});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SingleReelPlayerController>(
      init: SingleReelPlayerController(reel: reel),
      tag: reel.id,
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              // Player
              Positioned.fill(
                child: Obx(() {
                  if (!controller.isInitialized.value ||
                      controller.videoController == null) {
                    return const Center(child: LoadingWidget());
                  }
                  return GestureDetector(
                    onTap: controller.togglePlay,
                    child: AspectRatio(
                      aspectRatio:
                          controller.videoController!.value.aspectRatio,
                      child: VideoPlayer(controller.videoController!),
                    ),
                  );
                }),
              ),

              // Back Button
              Positioned(
                top: 40,
                left: 10,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),

              // User Info
              Positioned(
                bottom: 20,
                left: 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        UserAvatar.follower(
                          user: reel.user,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          reel.user.userName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

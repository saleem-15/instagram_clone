import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'package:instagram_clone/app/shared/loading_widget.dart';
import 'package:instagram_clone/app/shared/user_avatar.dart';
import 'package:instagram_clone/app/shared/animated_love_button.dart';
import '../controllers/single_reel_player_controller.dart';

class SingleReelPlayerScreen extends GetView<SingleReelPlayerController> {
  const SingleReelPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
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
                  final isPlaying = c.videoController!.value.isPlaying;
                  return GestureDetector(
                    onTap: c.togglePlay,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        AspectRatio(
                          aspectRatio: c.videoController!.value.aspectRatio,
                          child: VideoPlayer(c.videoController!),
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
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),

          // User Info (Bottom Left)
          Positioned(
            bottom: 20,
            right: 15,
            child: GetBuilder<SingleReelPlayerController>(
              id: 'user_info',
              builder: (c) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      if (!c.reel.user.isMe && !c.reel.user.doIFollowHim) ...[
                        const SizedBox(width: 10),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            minimumSize: const Size(60, 30),
                            backgroundColor: Colors.transparent,
                            side: const BorderSide(color: Colors.white),
                          ),
                          onPressed: c.followUser,
                          child: const Text('Follow',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ]
                    ],
                  ),
                  if (c.reel.caption.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        c.reel.caption,
                        style: const TextStyle(color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ),

          // Actions Sidebar (Bottom Right)
          Positioned(
            bottom: 120,
            left: 10,
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
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 15),

                  // Comment Button
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.comment,
                        color: Colors.white, size: 26),
                    onPressed: c.comment,
                  ),
                  Text(
                    '${c.reel.numOfComments}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 15),

                  // Send Button
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 28),
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

          // Video Progress Indicator
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Obx(() {
              if (controller.isInitialized.value &&
                  controller.videoController != null) {
                return SizedBox(
                  height: 4,
                  child: VideoProgressIndicator(
                    controller.videoController!,
                    allowScrubbing: true,
                    colors: const VideoProgressColors(
                      playedColor: Colors.white,
                      bufferedColor: Colors.white30,
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
  }
}

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:instagram_clone/core/utils/logger.dart';
import 'package:instagram_clone/core/utils/constants/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/features/story/controllers/user_story_controller.dart';
import 'package:instagram_clone/shared/loading_widget.dart';

import 'package:video_player/video_player.dart';

class StoryMedia extends StatelessWidget {
  const StoryMedia({
    super.key,
    required this.storyController,
  });

  final UserStoryController storyController;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.r),
      child: GetBuilder<UserStoryController>(
        tag: storyController.user.id,
        assignId: true,
        id: 'story media',
        builder: (controller) {
          final storyUrl = Api.normalizeUrl(storyController.currentStory.media);
          return storyUrl.isImageFileName
              ?

              /// image
              Builder(
                  builder: (_) {
                    final image = CachedNetworkImageProvider(storyUrl,
                        headers: Api.headers);
                    return Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 200.0, sigmaY: 200.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Image(
                            image: image,
                            errorBuilder: (context, error, stackTrace) {
                              AppLogger.error(
                                  'Story Media Image error: $storyUrl',
                                  error,
                                  stackTrace);
                              return const Center(
                                child: Icon(Icons.broken_image,
                                    color: Colors.grey),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                )
              :

              /// video
              Center(
                  child: FutureBuilder(
                    future: storyController.initilizeVideoController(storyUrl),
                    builder:
                        (_, AsyncSnapshot<VideoPlayerController> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const LoadingWidget();
                      }
                      if (snapshot.hasError) {
                        AppLogger.error('Story Media Video error: $storyUrl',
                            snapshot.error, snapshot.stackTrace);
                        return const Center(
                          child: Icon(Icons.broken_image, color: Colors.grey),
                        );
                      }
                      final videoController = snapshot.data!;

                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: AspectRatio(
                          aspectRatio: videoController.value.aspectRatio,
                          child: VideoPlayer(videoController),
                        ),
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}

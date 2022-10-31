import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/app/modules/story/controllers/user_story_controller.dart';
import 'package:instagram_clone/app/shared/loading_widget.dart';
import 'package:video_player/video_player.dart';

class StoryMedia extends StatelessWidget {
  const StoryMedia({
    Key? key,
    required this.storyController,
  }) : super(key: key);

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
          log('story media is updated');
          final storyUrl = storyController.currentStory.media;
          return storyUrl.isImageFileName
              ?

              /// image
              Builder(
                  builder: (_) {
                    final image = NetworkImage(storyUrl);
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
                          child: Image(image: image),
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
                    builder: (_, AsyncSnapshot<VideoPlayerController> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const LoadingWidget();
                      }
                      final videoController = snapshot.data!;

                      return AspectRatio(
                        aspectRatio: videoController.value.size.width / videoController.value.size.height,
                        child: VideoPlayer(videoController),
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}

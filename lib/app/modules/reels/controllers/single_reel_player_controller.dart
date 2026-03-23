import 'dart:developer';

import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:instagram_clone/app/models/reel.dart';
import 'package:instagram_clone/app/models/post.dart';
import 'package:instagram_clone/utils/constants/api.dart';

import 'package:flutter/material.dart';
import 'package:instagram_clone/app/modules/comments/controllers/comments_controller.dart';
import 'package:instagram_clone/app/modules/posts/services/set_post_is_loved_service.dart';
import 'package:instagram_clone/app/modules/posts/services/set_post_is_saved_service.dart';

class SingleReelPlayerController extends GetxController {
  final Reel reel;

  SingleReelPlayerController({required this.reel});

  VideoPlayerController? videoController;
  var isInitialized = false.obs;
  var isCommentsOpen = false.obs;

  var dragOffset = 0.0.obs;

  double get maxCommentsHeight {
    if (Get.context == null) return Get.height;
    return MediaQuery.of(Get.context!).size.height -
        MediaQuery.of(Get.context!).padding.top -
        MediaQuery.of(Get.context!).padding.bottom;
  }

  void onVerticalDragUpdate(DragUpdateDetails details) {
    
    if (details.primaryDelta != null) {
      dragOffset.value += details.primaryDelta!;

      final maxDragUp = (Get.height * 0.55) - maxCommentsHeight;
      if (dragOffset.value < maxDragUp) {
        dragOffset.value = maxDragUp;
      }
    }
  }

  void onVerticalDragEnd(DragEndDetails details) {
    final maxDragUp = (Get.height * 0.55) - maxCommentsHeight;

    // Swipe down to close
    if (dragOffset.value > 100 || (details.primaryVelocity ?? 0) > 300) {
      isCommentsOpen.value = false;
      dragOffset.value = 0.0;
      Get.delete<CommentsController>();
      resumeVideo();
    }
    // Swipe up to full screen
    else if (dragOffset.value < -100 || (details.primaryVelocity ?? 0) < -300) {
      dragOffset.value = maxDragUp;
      pauseVideo();
    }
    // Snap back to normal (55%)
    else {
      dragOffset.value = 0.0;
      resumeVideo();
    }
  }

  void pauseVideo() {
    if (videoController != null && videoController!.value.isPlaying) {
      videoController!.pause();
      update(['playback']);
    }
  }

  void resumeVideo() {
    if (videoController != null && !videoController!.value.isPlaying) {
      videoController!.play();
      update(['playback']);
    }
  }

  @override
  void onInit() {
    super.onInit();
    _initVideo();
  }

  Future<void> _initVideo() async {
    String formattedUrl = reel.reelMediaUrl.replaceAll('/public/', '/');
    videoController = VideoPlayerController.networkUrl(
      Uri.parse(formattedUrl),
      httpHeaders: Api.headers,
    );
    await videoController!.initialize();
    videoController!.setLooping(true);
    videoController!.play();
    videoController!.addListener(() {
      update(['playback']);
    });
    isInitialized(true);
  }

  void togglePlay() {
    if (videoController == null) return;
    if (videoController!.value.isPlaying) {
      videoController!.pause();
    } else {
      videoController!.play();
    }
    update(['playback']);
  }

  Future<void> onHeartPressed() async {
    reel.isFavorite = !reel.isFavorite;
    reel.numOfLikes += reel.isFavorite ? 1 : -1;
    update(['actions']);

    final isSuccess = await setPostIsLovedService(reel.id, reel.isFavorite);
    if (!isSuccess) {
      reel.isFavorite = !reel.isFavorite;
      reel.numOfLikes += reel.isFavorite ? 1 : -1;
      update(['actions']);
    }
  }

  Future<void> onSavePressed() async {
    reel.isSaved = !reel.isSaved;
    update(['actions']);

    final isSuccess = await setPostIsSavedService(reel.id, reel.isSaved);
    if (!isSuccess) {
      reel.isSaved = !reel.isSaved;
      update(['actions']);
    }
  }

  void comment() {
    log("isCommentsOpen: ${isCommentsOpen.value}------------------------");

    if (!isCommentsOpen.value) {
      final post = Post(
        id: reel.id,
        user: reel.user,
        isFavorite: reel.isFavorite,
        isSaved: reel.isSaved,
        numOfLikes: reel.numOfLikes,
        numOfComments: reel.numOfComments,
        caption: reel.caption,
        postContents: [reel.reelMediaUrl],
      );
      final commentsController = Get.put(CommentsController());
      commentsController.setPost(post);
      log("post is set---------------------------------");
    } else {
      Get.delete<CommentsController>();
    }

    isCommentsOpen.toggle();
  }

  void followUser() {
    reel.user.doIFollowHim = true;
    update(['user_info']);
  }

  @override
  void onClose() {
    videoController?.dispose();
    super.onClose();
  }
}

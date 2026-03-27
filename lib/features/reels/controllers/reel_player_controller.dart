import 'package:instagram_clone/features/follows/services/follow_user_service.dart';
import 'package:instagram_clone/features/follows/services/unfollow_service.dart';
import 'package:instagram_clone/features/posts/services/set_post_is_saved_service.dart';
import 'package:instagram_clone/features/posts/services/set_post_is_loved_service.dart';
import 'package:instagram_clone/features/reels/services/reels_service.dart';
import 'package:instagram_clone/core/services/video_service.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:instagram_clone/core/models/reel.dart';
import 'package:instagram_clone/core/models/post.dart';

import 'package:flutter/material.dart';
import 'package:instagram_clone/features/comments/controllers/comments_controller.dart';

/// Every Reel Has Its Own Controller
class ReelPlayerController extends GetxController {
  final Reel reel;
  final String tag;

  ReelPlayerController({required this.reel, required this.tag});

  VideoPlayerController? videoController;
  var isInitialized = false.obs;
  var isCommentsOpen = false.obs;
  late final bool showFollowButton;

  var dragOffset = 0.0.obs;
  var availableHeight = 0.0.obs;

  double get maxDragUp => (availableHeight.value * 0.5) - availableHeight.value;

  @override
  void onInit() {
    super.onInit();
    showFollowButton = (!reel.user.isMe && !reel.user.doIFollowHim);
    _initVideo();
  }

  void onVerticalDragUpdate(DragUpdateDetails details) {
    if (details.primaryDelta != null) {
      dragOffset.value += details.primaryDelta!;

      if (dragOffset.value < maxDragUp) {
        dragOffset.value = maxDragUp;
      }
    }
  }

  void onVerticalDragEnd(DragEndDetails details) {
    // Swipe down to close
    if (dragOffset.value > 100 || (details.primaryVelocity ?? 0) > 300) {
      isCommentsOpen.value = false;
      dragOffset.value = 0.0;
      isCommentsOpen.value = false;
      Get.delete<CommentsController>(tag: tag);
      _resumeVideo();
    }
    // Swipe up to full screen
    else if (dragOffset.value < -100 || (details.primaryVelocity ?? 0) < -300) {
      dragOffset.value = maxDragUp;
      _pauseVideo();
    }
    // Snap back to normal (50%)
    else {
      dragOffset.value = 0.0;
      _resumeVideo();
    }
  }

  void _pauseVideo() {
    if (videoController != null && videoController!.value.isPlaying) {
      videoController!.pause();
      update(['playback']);
    }
  }

  void _resumeVideo() {
    if (videoController != null && !videoController!.value.isPlaying) {
      videoController!.play();
      update(['playback']);
    }
  }

  void playVideo() {
    _resumeVideo();
  }

  void pauseVideo() {
    _pauseVideo();
  }

  Future<void> _initVideo() async {
    videoController = await VideoService.to.getController(reel.reelMediaUrl);
    videoController!.setLooping(true);
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
      final commentsController = Get.put(CommentsController(), tag: tag);
      commentsController.setPost(post);
    } else {
      Get.delete<CommentsController>(tag: tag);
    }

    isCommentsOpen.toggle();
  }

  void onFollowUserPressed() async {
    final originalFollowState = reel.user.doIFollowHim;

    // Optimistic update
    reel.user.doIFollowHim = !originalFollowState;
    update(['user_info']);

    bool isSuccess;
    if (originalFollowState) {
      isSuccess = await unFollowService(reel.user.id);
    } else {
      isSuccess = await followService(reel.user.id);
    }

    if (!isSuccess) {
      // Revert on failure
      reel.user.doIFollowHim = originalFollowState;
      update(['user_info']);
    }
  }

  @override
  void onClose() {
    VideoService.to.releaseController(reel.reelMediaUrl);
    super.onClose();
  }
}

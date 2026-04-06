import 'package:instagram_clone/features/follows/services/follow_user_service.dart';
import 'package:instagram_clone/features/follows/services/unfollow_service.dart';
import 'package:instagram_clone/features/posts/services/set_post_is_saved_service.dart';
import 'package:instagram_clone/features/posts/services/set_post_is_loved_service.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/models/reel.dart';
import 'package:instagram_clone/core/models/post.dart';

import 'package:flutter/material.dart';
import 'package:instagram_clone/features/comments/controllers/comments_controller.dart';
import 'package:instagram_clone/core/utils/my_video_controller.dart';
import 'package:instagram_clone/features/reels/controllers/reels_controller.dart';

/// Every Reel Has Its Own Controller
class ReelPlayerController extends GetxController {
  final Reel reel;
  final String tag;

  ReelPlayerController({required this.reel, required this.tag});

  late final MyVideoController myVideoController;
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

    // Try to claim a pre-initialized controller from ReelsController.
    // If the user is swiping through the feed, the next reel's decoder
    // is already warm — resulting in zero loading time.
    MyVideoController? preInit;
    try {
      preInit = Get.find<ReelsController>().takePreInitController(reel.reelMediaUrl);
    } catch (_) {
      // ReelsController may not exist (e.g., reel opened from a profile).
    }

    myVideoController = preInit ?? MyVideoController(videoUrl: reel.reelMediaUrl);

    // Idempotent: if pre-init already completed, this returns immediately.
    myVideoController.initialize().then((_) {
      isInitialized(true);
      update(['playback']);
    });
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
    myVideoController.pauseVideo();
    update(['playback']);
  }

  void _resumeVideo() {
    myVideoController.playVideo();
    update(['playback']);
  }

  void playVideo() {
    _resumeVideo();
  }

  void pauseVideo() {
    _pauseVideo();
  }

  void togglePlay() {
    if (myVideoController.isPaused) {
      myVideoController.playVideo();
    } else {
      myVideoController.pauseVideo();
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
    myVideoController.disposeVideo();
    super.onClose();
  }
}

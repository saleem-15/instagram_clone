import 'package:instagram_clone/features/posts/services/set_post_is_saved_service.dart';
import 'package:instagram_clone/features/posts/services/set_post_is_loved_service.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:get/get.dart';
import 'package:flutter/services.dart';

import 'package:instagram_clone/core/models/post.dart';
import 'package:instagram_clone/routes/app_pages.dart';
import 'package:instagram_clone/core/utils/my_video_controller.dart';

class PostsController extends GetxController {
  final Map<String, int> postsIndex = {};
  final Map<String, MyVideoController> myVideoControllers = {};
  static final Map<String, AnimationController> heartAnimationControllers = {};

  late final CarouselSliderController carouselController;

  @override
  void onInit() {
    carouselController = CarouselSliderController();
    super.onInit();
  }

  void viewPostComments(Post post) {
    Get.toNamed(
      Routes.COMMENTS,
      arguments: post,
    );
  }

  void comment(Post post) {
    Get.toNamed(
      Routes.COMMENTS,
      parameters: {'isTextFieldFocused': 'true'},
      arguments: post,
    );
  }

  Future<void> onHeartPressed(Post post) async {
    HapticFeedback.lightImpact();

    /// change the value to the opposite
    post.isFavorite = !post.isFavorite;
    heartAnimationControllers[post.id]!.reset();
    heartAnimationControllers[post.id]!.forward();
    update(['${post.id} love button']);

    final isSuccess = await setPostIsLovedService(post.id, post.isFavorite);

    /// if the request failed return to the original value
    if (!isSuccess) {
      post.isFavorite = !post.isFavorite;
      update(['${post.id} love button']);
    }
  }

  Future<void> onSaveButtonPressed(Post post) async {
    HapticFeedback.selectionClick();

    /// Optimistic UI: change the value immediately
    post.isSaved = !post.isSaved;
    update(['${post.id} save button']);

    final isSuccess = await setPostIsSavedService(post.id, post.isSaved);

    /// If the request failed, revert to the original value
    if (!isSuccess) {
      post.isSaved = !post.isSaved;
      update(['${post.id} save button']);
    }
  }

  void onImageSlided(Post post, int index, CarouselPageChangedReason reason) {
    postsIndex[post.id] = index;
    update(['selected content index']);
  }

  Future<MyVideoController> initilizeVideoController(String videoUrl) async {
    if (myVideoControllers.containsKey(videoUrl)) {
      return myVideoControllers[videoUrl]!;
    }

    final myVideoController = MyVideoController(videoUrl: videoUrl);
    await myVideoController.initialize();

    myVideoControllers[videoUrl] = myVideoController;

    return myVideoController;
  }

  void onVideoTapped(
      MyVideoController myVideoController, Post post, int videoIndex) {
    myVideoController.toggleMute();
    update(['${post.id} $videoIndex']);
  }

  void registerPost(Post post) {
    postsIndex.addIf(!postsIndex.containsKey(post.id), post.id, 0);
  }

  Future<void> onPostDoubleTap(Post post, RxBool isHeartVisible) async {
    onHeartPressed(post);
    isHeartVisible(true);
    await Future.delayed(const Duration(milliseconds: 1500));
    isHeartVisible(false);
  }

  void share(Post post) {}

  @override
  void onClose() {
    for (var controller in myVideoControllers.values) {
      controller.dispose();
    }
    myVideoControllers.clear();
    super.onClose();
  }
}

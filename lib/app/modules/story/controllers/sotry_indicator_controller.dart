import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'user_story_controller.dart';

/// for every user there is a [StoryIndicatorController] controller
class StoryIndicatorController extends GetxController with GetSingleTickerProviderStateMixin {
  StoryIndicatorController({required this.maxSingleIndicatorWidth});

  late AnimationController animationController;

  /// used to determine the [upperBound] of the [animationController]
  late final double maxSingleIndicatorWidth;

  @override
  void onInit() {
    animationController = AnimationController(
      duration: IMAGE_STORY_DURATION,
      upperBound: maxSingleIndicatorWidth,
      vsync: this,
    );

    super.onInit();
  }

  /// starts a new animation even if there a paused animation
  /// to resume animation use
  /// ```dart
  ///  resumeAnimation()
  /// ```
  void startAnimation(Duration animationDuration) {
    animationController.reset();
    animationController.duration = animationDuration;
    animationController.forward();
  }

  void pauseAnimation() {
    animationController.stop(canceled: false);
  }

  /// resumes an existing  animation
  void resumeAnimation() {
    if (!animationController.isAnimating) {
      animationController.forward();
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}

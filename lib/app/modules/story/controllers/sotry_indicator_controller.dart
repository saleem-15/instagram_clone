import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'user_story_controller.dart';

/// for every user there is a [StoryIndicatorController] controller
class StoryIndicatorController extends GetxController with GetSingleTickerProviderStateMixin {
  StoryIndicatorController({required this.maxSingleIndicatorWidth});

  late AnimationController animationController;
  late final double maxSingleIndicatorWidth;

  @override
  void onInit() {
    animationController = AnimationController(
      duration: STORY_DURATION,
      upperBound: maxSingleIndicatorWidth,
      vsync: this,
    );

    super.onInit();
  }

  @override
  void onReady() {
    startAnimation();
    animationController.addListener(() {
      // log('animation ${animationController.value}');
    });
    super.onReady();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void startAnimation() {
    animationController.reset();
    animationController.forward();
  }

  void pauseAnimation() {
    animationController.stop(canceled: false);
  }

  void resumeAnimation() {
    animationController.forward();
  }
}

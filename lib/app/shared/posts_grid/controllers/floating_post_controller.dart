import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

class FloatingPostController extends GetxController with GetSingleTickerProviderStateMixin {
  // late  Post post;

  late AnimationController _animationController;
  late Animation<double> animation;

  @override
  void onInit() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
      lowerBound: 0.5,
      upperBound: 1,
    );

    animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    super.onInit();
  }

  void startAnimation() {
    _animationController.forward();
  }

  void resetAnimation() {
    _animationController.reset();
  }

  @override
  void onClose() {
    _animationController.dispose();
    super.onClose();
  }
}

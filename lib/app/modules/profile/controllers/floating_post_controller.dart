import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

import 'package:instagram_clone/app/models/post.dart';

class FloatingPostController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final Post post;

  late AnimationController _animationController;
  late Animation<double> animation;

  @override
  void onInit() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
      value: 0.5,
      upperBound: 1,
    );
    animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward();
    super.onInit();
  }

  void setFloatingPost(Post post) {
    this.post = post;
  }

  @override
  void onClose() {
    _animationController.dispose();
    super.onClose();
  }
}

import 'package:flutter/material.dart';

import 'package:instagram_clone/shared/posts_grid/views/posts_grid_view.dart';

import '../controllers/user_posts_controller.dart';

class ProfilePostsTap extends StatelessWidget {
  const ProfilePostsTap({
    super.key,
    required this.controller,
  });

  final UserPostsController controller;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.onRefresh,
      child: PostsGridView(
        controller: controller.postsGridController,
      ),
    );
  }
}

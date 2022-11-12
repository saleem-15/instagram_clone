import 'package:flutter/material.dart';

import 'package:instagram_clone/app/shared/posts_grid/views/posts_grid_view.dart';

import '../controllers/user_posts_controller.dart';

class ProfilePostsTap extends StatelessWidget {
  const ProfilePostsTap({
    Key? key,
    required this.controller,
  }) : super(key: key);

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

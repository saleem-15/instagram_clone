import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app/shared/posts_grid/views/posts_grid_view.dart';

import '../controllers/saved_posts_controller.dart';

class SavedPostsScreen extends GetView<SavedPostsController> {
  const SavedPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: Navigator.canPop(context),
      appBar: AppBar(
        primary: Navigator.canPop(context),
        title: const Text('Saved'),
      ),
      body: RefreshIndicator(
        onRefresh: controller.onRefresh,
        child: PostsGridView(
          controller: controller.postsGridController,
        ),
      ),
    );
  }
}

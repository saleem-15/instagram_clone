import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:instagram_clone/app/models/post.dart';
import 'package:instagram_clone/app/modules/profile/views/my_post_grid_tile_view.dart';
import 'package:instagram_clone/app/shared/loading_widget.dart';

import '../controllers/user_posts_controller.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class ProfilePostsTap extends GetView<UserPostsController> {
  const ProfilePostsTap({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.onRefresh,
      child: PagedGridView<int, Post>(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
        ),
        pagingController: controller.pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          itemBuilder: (context, post, index) => MyPostGridTileView(
            post: post,
            onPostPressed: controller.onPostPressStarted,
            onPressedGone: controller.onPostPressEnded,
          ),
          firstPageProgressIndicatorBuilder: (context) {
            return const Center(
              child: LoadingWidget(),
            );
          },
          firstPageErrorIndicatorBuilder: (context) =>
              Text(controller.pagingController.error.toString()),
          noItemsFoundIndicatorBuilder: (context) => Center(
            child: Text(
              'No Posts was Found'.tr,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          newPageErrorIndicatorBuilder: (context) => const Text('coludnt load'),
        ),
      ),
    );
  }
}

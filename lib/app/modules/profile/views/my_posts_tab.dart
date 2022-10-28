import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:instagram_clone/app/models/post.dart';
import 'package:instagram_clone/app/modules/profile/views/my_post_grid_tile_view.dart';
import 'package:instagram_clone/app/shared/loading_widget.dart';

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
      child: PagedGridView<int, Post>(
        showNewPageErrorIndicatorAsGridChild: false,
        showNoMoreItemsIndicatorAsGridChild: false,
        showNewPageProgressIndicatorAsGridChild: false,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
        ),
        pagingController: controller.pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          //
          itemBuilder: (context, post, index) => MyPostGridTileView(
            post: post,
            onPostPressed: controller.onPostPressStarted,
            onPressedGone: controller.onPostPressEnded,
          ),
          //
          firstPageProgressIndicatorBuilder: (_) => loadingWidget(),
          //
          newPageProgressIndicatorBuilder: (_) => loadingWidget(),
          //
          noItemsFoundIndicatorBuilder: (context) => noPostFoundWidget(context),
          //
          firstPageErrorIndicatorBuilder: (context) => errorWidget(),
          //
          newPageErrorIndicatorBuilder: (_) => errorWidget(),
        ),
      ),
    );
  }

  Center noPostFoundWidget(BuildContext context) {
    return Center(
      child: Text(
        'No Posts was Found'.tr,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget loadingWidget() => const Center(
        child: LoadingWidget(
          size: 45,
        ),
      );

  Widget errorWidget() => Center(
        child: Text(
          controller.pagingController.error.toString(),
        ),
      );
}

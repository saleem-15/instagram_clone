import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:instagram_clone/app/models/post.dart';
import 'package:instagram_clone/app/modules/profile/views/my_post_grid_tile_view.dart';
import 'package:instagram_clone/app/shared/search_field.dart';

import '../controllers/explorer_controller.dart';

class ExplorerView extends GetView<ExplorerController> {
  const ExplorerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SearchTextField(
              onTap: controller.onSearchFieldPressed,
              isReadOnly: true,
              textController: controller.searchTextController,
              onEditingComplete: controller.search,
            ),
            Expanded(
              child: PagedGridView<int, Post>(
                padding: const EdgeInsets.only(top: 7),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 3,
                ),
                pagingController: controller.pagingController,
                builderDelegate: PagedChildBuilderDelegate(
                  itemBuilder: (context, post, index) => MyPostGridTileView(
                    post: post,
                    onPostPressed: controller.onPostPressed,
                    onPressedGone: controller.onPostPressGone,
                  ),
                  firstPageErrorIndicatorBuilder: (context) =>
                      Text(controller.pagingController.error.toString()),
                  noItemsFoundIndicatorBuilder: (context) => Center(
                    child: Text(
                      'No Posts was Found'.tr,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  newPageErrorIndicatorBuilder: (context) =>
                      const Text('coludnt load'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

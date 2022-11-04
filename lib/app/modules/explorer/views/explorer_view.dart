import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:instagram_clone/app/models/post.dart';
import 'package:instagram_clone/app/shared/my_post_grid_tile_view.dart';
import 'package:instagram_clone/app/shared/loading_widget.dart';
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
                showNewPageErrorIndicatorAsGridChild: false,
                showNoMoreItemsIndicatorAsGridChild: false,
                showNewPageProgressIndicatorAsGridChild: false,
                padding: const EdgeInsets.only(top: 7),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 3,
                ),
                pagingController: controller.pagingController,
                //
                builderDelegate: PagedChildBuilderDelegate(
                  itemBuilder: (_, post, __) => MyPostGridTileView(
                    post: post,
                    onPostPressed: controller.onPostPressed,
                    onPressedGone: controller.onPostPressGone,
                  ),

                  //
                  firstPageProgressIndicatorBuilder: (_) => loadingWidget(),
                  //
                  newPageProgressIndicatorBuilder: (_) => loadingWidget(),
                  //
                  noItemsFoundIndicatorBuilder: (context) => noPostsFoundWdget(context),
                  //
                  firstPageErrorIndicatorBuilder: (_) => errorWidget(),
                  //
                  newPageErrorIndicatorBuilder: (_) => errorWidget(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget noPostsFoundWdget(BuildContext context) {
    return Center(
      child: Text(
        'No Posts was Found'.tr,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget loadingWidget() => const Center(
        child: LoadingWidget(),
      );

  Widget errorWidget() => Center(
        child: Text(
          controller.pagingController.error.toString(),
        ),
      );
}

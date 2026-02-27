// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:instagram_clone/app/models/post.dart';
import 'package:instagram_clone/app/shared/loading_widget.dart';
import 'package:instagram_clone/app/shared/posts_grid/views/post_grid_tile.dart';

import '../controllers/posts_grid_controller.dart';

class PostsGridView extends StatelessWidget {
  const PostsGridView({
    Key? key,
    required this.controller,
    this.sliverGridDelegate =
        const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      crossAxisSpacing: 3,
      mainAxisSpacing: 3,
    ),
  }) : super(key: key);

  final PostsGridController controller;
  final SliverGridDelegate sliverGridDelegate;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        PagedGridView<int, Post>(
          showNewPageErrorIndicatorAsGridChild: false,
          showNoMoreItemsIndicatorAsGridChild: false,
          showNewPageProgressIndicatorAsGridChild: false,
          padding: const EdgeInsets.only(top: 7),
          gridDelegate: sliverGridDelegate,
          pagingController: controller.pagingController,
          //
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (_, post, __) => PostGridTile(
              post: post,
              onPostPressed: controller.onPostPressed,
              onPressedGone: controller.onPostPressGone,
            ),

            //
            firstPageProgressIndicatorBuilder: (_) => loadingWidget(),
            //
            newPageProgressIndicatorBuilder: (_) => loadingWidget(),
            //
            noItemsFoundIndicatorBuilder: (context) =>
                noPostsFoundWdget(context),
            //
            firstPageErrorIndicatorBuilder: (_) => errorWidget(),
            //
            newPageErrorIndicatorBuilder: (_) => errorWidget(),
          ),
        ),
        // SizedBox(
        //   width: MediaQuery.of(context).size.width,
        //   height: MediaQuery.of(context).size.height,
        //   child: FloatingPostView(
        //     post: controller.pagingController.itemList!.first,
        //     controller: Get.put(FloatingPostController()),
        //   ),
        // )
      ],
    );
  }

  Widget noPostsFoundWdget(BuildContext context) {
    return Center(
      child: Text(
        'No Posts was Found'.tr,
        style: Theme.of(context).textTheme.titleLarge,
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

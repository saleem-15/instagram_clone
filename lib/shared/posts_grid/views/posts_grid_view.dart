// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:instagram_clone/core/models/post.dart';
import 'package:instagram_clone/shared/loading_widget.dart';
import 'package:instagram_clone/shared/no_items_found_widget.dart';
import 'package:instagram_clone/shared/posts_grid/views/post_grid_tile.dart';

import '../controllers/posts_grid_controller.dart';

class PostsGridView extends StatelessWidget {
  const PostsGridView({
    super.key,
    required this.controller,
    this.sliverGridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      crossAxisSpacing: 3,
      mainAxisSpacing: 3,
    ),
  });

  final PostsGridController controller;
  final SliverGridDelegate sliverGridDelegate;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        PagingListener<int, Post>(
          controller: controller.pagingController,
          builder: (context, state, fetchNextPage) => PagedGridView<int, Post>(
            showNewPageErrorIndicatorAsGridChild: false,
            showNoMoreItemsIndicatorAsGridChild: false,
            showNewPageProgressIndicatorAsGridChild: false,
            padding: const EdgeInsets.only(top: 7),
            gridDelegate: sliverGridDelegate,
            state: state,
            fetchNextPage: fetchNextPage,
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
              firstPageErrorIndicatorBuilder: (_) => errorWidget(state),
              //
              newPageErrorIndicatorBuilder: (_) => errorWidget(state),
            ),
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
    return NoItemsFoundWidget(
      customIcon: Image.asset(
        'assets/images/camera_inside_circle.png',
        width: 120.sp,
        color: Theme.of(context).iconTheme.color,
      ),
      title: 'No Posts Yet',
      message: 'When you share photos or videos, they\'ll appear here.',
    );
  }

  Widget loadingWidget() => const Center(
        child: LoadingWidget(),
      );

  Widget errorWidget(PagingState state) => Center(
        child: Text(
          state.error?.toString() ?? 'Error loading posts',
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:instagram_clone/app/models/post.dart';
import 'package:instagram_clone/app/modules/posts/views/post_view.dart';
import 'package:instagram_clone/app/modules/story/views/stories_view.dart';
import 'package:instagram_clone/app/shared/loading_widget.dart';

import '../controllers/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.red,
        // toolbarHeight: 50,
        title: Image.asset(
          'assets/icons/instagram-word-logo-removebg.png',
          width: 120.sp,
        ),
      ),
      body: PagingListener<int, Post>(
        controller: controller.pagingController,
        builder: (context, state, fetchNextPage) => CustomScrollView(
          slivers: [
            /// stories List
            SliverToBoxAdapter(
              child: const StoriesView().paddingOnly(
                bottom: 8.sp,
              ),
            ),

            /// posts List
            PagedSliverList<int, Post>(
              state: state,
              fetchNextPage: fetchNextPage,
              builderDelegate: PagedChildBuilderDelegate(
                //
                itemBuilder: (_, post, __) => PostView(
                  post: post,
                ).paddingOnly(bottom: 3.sp),
                //
                firstPageErrorIndicatorBuilder: (_) => errorWidget(state),
                //

                noItemsFoundIndicatorBuilder: (context) =>
                    noPostsFoundWidget(context),
                //
                firstPageProgressIndicatorBuilder: (_) => loadingWidget(),
                //
                newPageProgressIndicatorBuilder: (_) => loadingWidget(),
                //
                newPageErrorIndicatorBuilder: (_) => errorWidget(state),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget noPostsFoundWidget(BuildContext context) {
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

  Widget errorWidget(PagingState state) => Center(
        child: Text(
          state.error?.toString() ?? 'Error loading posts',
        ),
      );
}

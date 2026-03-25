import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:instagram_clone/app/models/post.dart';
import 'package:instagram_clone/app/modules/posts/views/post_view.dart';
import 'package:instagram_clone/app/modules/story/views/stories_view.dart';
import 'package:instagram_clone/app/shared/loading_widget.dart';
import 'package:instagram_clone/app/shared/no_items_found_widget.dart';

import '../controllers/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SvgPicture.asset(
          fit: BoxFit.scaleDown,
          'assets/icons/heart.svg',
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        ),
        centerTitle: true,
        title: SvgPicture.asset(
          'assets/icons/instagram logo.svg',
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
          width: 115.sp,
        ),
        actions: [
          Icon(
            Icons.add,
            size: 25.sp,
          ),
          SizedBox(
            width: 10.w,
          ),
        ],
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
    return NoItemsFoundWidget(
      title: 'No Posts Yet',
      message: 'Follow your friends and family to see their updates here.',
      onActionPressed: () => controller.pagingController.refresh(),
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

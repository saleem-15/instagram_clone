import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/features/posts/views/post_view.dart';
import 'package:instagram_clone/features/story/views/stories_view.dart';
import 'package:instagram_clone/shared/loading_widget.dart';
import 'package:instagram_clone/shared/no_items_found_widget.dart';

import '../controllers/home_controller.dart';

// HomeScreen (public): Acts as the public entry point for your Router.
// Its only job is to resolve the dependency (controller = Get.find()) and pass it down.
// _HomeScreenBody (private): Only worries about the UI lifecycle (initState, ScrollController). 
// It doesn't need to know where the controller came from,
// making it potentially more reusable and easier to mock in tests
// because you are passing the controller in through the constructor.
class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _HomeScreenBody(controller: controller);
  }
}

/// A [StatefulWidget] so we can own and dispose a [ScrollController]
/// without polluting the GetX controller with UI concerns.
class _HomeScreenBody extends StatefulWidget {
  const _HomeScreenBody({required this.controller});
  final HomeController controller;

  @override
  State<_HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<_HomeScreenBody> {
  late final ScrollController _scrollController;

  HomeController get controller => widget.controller;

  // ─── Lifecycle ────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  // ─── Infinite scroll detection ────────────────────────────────────────

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;

    if (maxScroll - currentScroll <= 200) {
      controller.loadMorePosts();
    }
  }

  // ─── Build ────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: Navigator.canPop(context),
      body: RefreshIndicator(
        onRefresh: controller.refreshFeed,
        child: Obx(() {
          // ── Initial loading state ──────────────────────────────────
          if (controller.isInitialLoading.value) {
            return const Center(child: LoadingWidget());
          }

          // ── Empty state ───────────────────────────────────────────
          if (controller.posts.isEmpty) {
            return _buildEmptyState(context);
          }

          // ── Feed ──────────────────────────────────────────────────
          return CustomScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              _buildAppBar(context),
              _buildStoriesSection(),
              _buildPostsList(),
              _buildLoadingMoreIndicator(),
            ],
          );
        }),
      ),
    );
  }

  // ─── Sub‑widgets ──────────────────────────────────────────────────────

  SliverAppBar _buildAppBar(BuildContext context) {
    return SliverAppBar(
      primary: Navigator.canPop(context),
      floating: true,
      snap: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
        Icon(Icons.add, size: 25.sp),
        SizedBox(width: 10.w),
      ],
    );
  }

  SliverToBoxAdapter _buildStoriesSection() {
    return SliverToBoxAdapter(
      child: const StoriesView().paddingOnly(bottom: 8.sp),
    );
  }

  SliverList _buildPostsList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final post = controller.posts[index];
          return PostView(post: post).paddingOnly(bottom: 3.sp);
        },
        childCount: controller.posts.length,
      ),
    );
  }

  SliverToBoxAdapter _buildLoadingMoreIndicator() {
    if (!controller.isLoadingMore.value) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.sp),
        child: const Center(child: LoadingWidget()),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    // Wrap in a scrollable so that RefreshIndicator still works
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        _buildAppBar(context),
        SliverFillRemaining(
          child: NoItemsFoundWidget(
            title: 'No Posts Yet',
            message:
                'Follow your friends and family to see their updates here.',
            onActionPressed: controller.refreshFeed,
          ),
        ),
      ],
    );
  }
}

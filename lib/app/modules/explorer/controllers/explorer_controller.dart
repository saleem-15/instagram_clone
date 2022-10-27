import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:instagram_clone/app/models/post.dart';
import 'package:instagram_clone/app/modules/profile/views/floating_post_view.dart';
import 'package:instagram_clone/app/routes/app_pages.dart';

import '../services/fetch_explorer_posts_service.dart';

class ExplorerController extends GetxController {
  final TextEditingController searchTextController = TextEditingController();

  int numOfPages = 5;
  final pagingController = PagingController<int, Post>(
    firstPageKey: 1,
  );

  final RxBool isPostFloating = false.obs;
  late Post floatingPost;

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) async {
      fetchPosts(pageKey);
    });

    isPostFloating.listen((isPostFloating) {
      if (isPostFloating) {
        Get.dialog(
          FloatingPostView(post: floatingPost),
        );
      } else {
        Get.back();
      }
    });
    super.onInit();
  }

  Future<void> fetchPosts(int pageKey) async {
    try {
      final followersNewPage = await fetchExplorerPostsService(pageKey);

      final isLastPage = numOfPages == pageKey;

      if (isLastPage) {
        pagingController.appendLastPage(followersNewPage);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(followersNewPage, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
      rethrow;
    }
  }

  void search() {}

  onPostPressed(Post post) {
    // Get.lazyPut(() => FollowsTabController(), fenix: true);
    floatingPost = post;
    isPostFloating(true);

    // Get.dialog(FloatingPostView(post: post));
  }

  onPostPressGone(Post post) {
    isPostFloating(false);
  }

  onTap(Post post) {}

  void onSearchFieldPressed() {
    Get.toNamed(Routes.SEARCH);
  }
}

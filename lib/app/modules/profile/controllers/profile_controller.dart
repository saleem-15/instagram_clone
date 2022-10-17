import 'dart:developer';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:instagram_clone/app/models/post.dart';
import 'package:instagram_clone/app/modules/profile/views/add_post_bottom_sheet.dart';
import 'package:instagram_clone/app/routes/app_pages.dart';

import '../services/fetch_my_posts_service.dart';
import '../views/floating_post_view.dart';

class ProfileController extends GetxController {
  final name = 'Saleem Mahdi';
  final username = 'saleemmahdi10';

  int numOfPages = 5;
  final pagingController = PagingController<int, Post>(
    firstPageKey: 1,
  );
  int postNum = 0;
  int followersNum = 12;
  int followingNum = 33;

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
      log('fetch posts');
      final followersNewPage = await fetchMyPostsService(pageKey);

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

  void goToFollowers() {
    Get.toNamed(Routes.FOLLOWERS);
  }

  void goToFollowing() {
    Get.toNamed(Routes.FOLLOWING);
  }

  void showAddPostBottomSheet() {
    Get.bottomSheet(const AddPostBottomSheet());
  }

  void showSettingsBottomSheet() {}

  onPostLongPressed(Post post) {
    // Get.lazyPut(() => FollowsTabController(), fenix: true);
    floatingPost = post;
    isPostFloating(true);

    // Get.dialog(FloatingPostView(post: post));
  }

  onPostLongPressGone(Post post) {
    isPostFloating(false);
  }
}

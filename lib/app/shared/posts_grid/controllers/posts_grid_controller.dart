import 'dart:developer';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:instagram_clone/app/models/post.dart';

import '../views/floating_post_view.dart';
import 'floating_post_controller.dart';

class PostsGridController extends GetxController {
  PostsGridController({required this.fetchItemsService});

  final floatingPostController = Get.put(FloatingPostController());

  /// the function that is used to fetch the posts,
  /// it must accepts a pageKey (for pagination)
  final Future<List<Post>> Function(int pageKey, RxInt numOfPages)
      fetchItemsService;
  late RxInt numOfPages;

  late final PagingController<int, Post> pagingController;

  final RxBool isPostFloating = false.obs;
  late Post floatingPost;

  @override
  void onInit() {
    numOfPages = RxInt(2);

    pagingController = PagingController<int, Post>(
      getNextPageKey: getNextPageKey,
      fetchPage: fetchPosts,
    );

    isPostFloating.listen((isPostFloating) {
      if (isPostFloating) {
        showFloatingPost();
      } else {
        hideFloatingPost();
      }
    });
    super.onInit();
  }

  void hideFloatingPost() {
    floatingPostController.resetAnimation();
    Get.back();
  }

  void showFloatingPost() {
    Get.dialog(
      FloatingPostView(
        post: floatingPost,
        controller: floatingPostController,
      ),
    );
    floatingPostController.startAnimation();
  }

  int? getNextPageKey(PagingState<int, Post> state) {
    int currentPage = state.nextIntPageKey - 1;
    if (currentPage >= numOfPages.value) {
      return null;
    }

    return state.nextIntPageKey;
  }

  Future<List<Post>> fetchPosts(int pageKey) async {
    try {
      final followersNewPage = await fetchItemsService(pageKey, numOfPages);

      return followersNewPage;
    } catch (error) {
      log("error fetching Posts: $error");
      return [];
    }
  }

  void onPostPressed(Post post) {
    // Get.lazyPut(() => FollowsTabController(), fenix: true);
    floatingPost = post;
    isPostFloating(true);

    // Get.dialog(FloatingPostView(post: post));
  }

  void onPostPressGone(Post post) {
    isPostFloating(false);
  }

  void onTap(Post post) {}
}

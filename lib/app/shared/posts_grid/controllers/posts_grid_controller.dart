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
  final Future<List<Post>> Function(int pageKey, RxInt numOfPages) fetchItemsService;
  late RxInt numOfPages;

  final pagingController = PagingController<int, Post>(
    firstPageKey: 1,
  );

  final RxBool isPostFloating = false.obs;
  late Post floatingPost;

  @override
  void onInit() {
    numOfPages = RxInt(2);
    pagingController.addPageRequestListener((pageKey) async {
      fetchPosts(pageKey);
    });

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

  Future<void> fetchPosts(int pageKey) async {
    try {
      final followersNewPage = await fetchItemsService(pageKey, numOfPages);

      final isLastPage = numOfPages.value == pageKey;

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
}

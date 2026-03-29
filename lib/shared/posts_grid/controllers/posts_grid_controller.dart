
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:instagram_clone/core/models/post.dart';

import '../views/floating_post_view.dart';
import 'floating_post_controller.dart';

class PostsGridController extends GetxController {
  PostsGridController({required this.fetchItemsService});

  final floatingPostController = Get.put(FloatingPostController());

  /// The function that is used to fetch the posts.
  /// It accepts a [pageKey] for pagination and returns a record with the items and the [lastPage] number.
  final Future<({List<Post> posts, int lastPage})> Function(int pageKey)
      fetchItemsService;

  late int _lastPage;

  late final PagingController<int, Post> pagingController;

  final RxBool isPostFloating = false.obs;
  late Post floatingPost;

  @override
  void onInit() {
    _lastPage = 1;

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
    if (currentPage >= _lastPage) {
      return null;
    }

    return state.nextIntPageKey;
  }

  Future<List<Post>> fetchPosts(int pageKey) async {
    try {
      final result = await fetchItemsService(pageKey);
      _lastPage = result.lastPage;
      return result.posts;
    } catch (error) {
      // In case of error, return an empty list to stop loading or show an error state
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

import 'package:instagram_clone/features/profile/services/fetch_saved_posts_service.dart';
import 'dart:async';

import 'package:get/get.dart';
import 'package:instagram_clone/shared/posts_grid/controllers/posts_grid_controller.dart';


class SavedPostsController extends GetxController {
  late final PostsGridController postsGridController;

  @override
  void onInit() {
    postsGridController = Get.put(
      PostsGridController(
        fetchItemsService: (pageKey, numOfPages) =>
            fetchSavedPostsService(pageKey, numOfPages),
      ),
      tag: 'saved_posts',
    );
    super.onInit();
  }

  Future<void> onRefresh() async {
    postsGridController.pagingController.refresh();
  }
}

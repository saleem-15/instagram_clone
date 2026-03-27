import 'package:instagram_clone/features/profile/services/fetch_profile_posts_service.dart';
import 'package:instagram_clone/core/services/storage_service.dart';
import 'dart:async';

import 'package:get/get.dart';

import 'package:instagram_clone/core/models/user.dart';
import 'package:instagram_clone/shared/posts_grid/controllers/posts_grid_controller.dart';


class UserPostsController extends GetxController {
  // by default its my profile
  late final User user;

  late final PostsGridController postsGridController;

  @override
  void onInit() {
    user = Get.arguments ?? Get.find<StorageService>().getUserData;

    postsGridController = Get.put(
      PostsGridController(
        fetchItemsService: (pageKey, numOfPages) =>
            fetchProfilePostsService(user.id, pageKey, numOfPages),
      ),
      tag: user.id,
    );

    super.onInit();
  }

  Future<void> onRefresh() async {
    postsGridController.pagingController.refresh();
  }
}

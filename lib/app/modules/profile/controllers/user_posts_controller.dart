import 'dart:async';

import 'package:get/get.dart';

import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/app/shared/posts_grid/controllers/posts_grid_controller.dart';
import 'package:instagram_clone/app/storage/my_shared_pref.dart';

import '../services/fetch_profile_posts_service.dart';

class UserPostsController extends GetxController {
  // by default its my profile
  late final User user;

  late final PostsGridController postsGridController;

  @override
  void onInit() {
    user = Get.arguments ?? MySharedPref.getUserData;

    postsGridController = Get.put(
      PostsGridController(
        fetchItemsService: (pageKey, numOfPages) => fetchProfilePostsService(user.id, numOfPages),
      ),
    );

    super.onInit();
  }

  Future<void> onRefresh() async {
    postsGridController.pagingController.refresh();
  }
}

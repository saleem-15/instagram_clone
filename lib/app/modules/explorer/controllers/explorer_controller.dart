import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:instagram_clone/app/routes/app_pages.dart';
import 'package:instagram_clone/app/shared/posts_grid/controllers/posts_grid_controller.dart';

import '../services/fetch_explorer_posts_service.dart';

class ExplorerController extends GetxController {
  final TextEditingController searchTextController = TextEditingController();

  late final PostsGridController postsGridController;

  @override
  void onInit() {
    postsGridController = Get.put(
      PostsGridController(
        fetchItemsService: (pageKey, numOfPages) => fetchExplorerPostsService(
          pageKey,
          numOfPages,
        ),
      ),
    );

    super.onInit();
  }

  void onSearchFieldPressed() {
    Get.toNamed(Routes.SEARCH);
  }
}

import 'package:instagram_clone/features/explorer/services/fetch_explorer_posts_service.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:instagram_clone/routes/app_pages.dart';
import 'package:instagram_clone/shared/posts_grid/controllers/posts_grid_controller.dart';


class ExplorerController extends GetxController {
  final TextEditingController searchTextController = TextEditingController();

  late final PostsGridController postsGridController;

  @override
  void onInit() {
    postsGridController = Get.put(
      PostsGridController(
        fetchItemsService: (pageKey) => fetchExplorerPostsService(pageKey),
      ),
    );

    super.onInit();
  }

  void onSearchFieldPressed() {
    Get.toNamed(Routes.SEARCH);
  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/app/routes/app_pages.dart';

import '../services/get_followers_service.dart';

class FollowersController extends GetxController {
  int numOfPages = 1;
  int setNumOfPages = 1;
  int totalNumOfProducts = 1;

  final pagingController = PagingController<int, User>(
    firstPageKey: 1,
  );

  final searchTextController = TextEditingController();
  @override
  onInit() {
    pagingController.addPageRequestListener((pageKey) async {
      fetchFollowers(pageKey);
    });
    super.onInit();
  }

  Future<void> fetchFollowers(int pageKey) async {
    try {
      final followersNewPage = await fetchFollowersService(pageKey);

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

    goToUserProfile(User following) {
    Get.toNamed(
      Routes.PROFILE,
      arguments: following,
    );
  }

  void search() {}
}

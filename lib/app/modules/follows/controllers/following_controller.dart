import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/app/modules/follows/services/unfollow_service.dart';
import 'package:instagram_clone/app/routes/app_pages.dart';

import '../services/get_following_service.dart';

class FollowingController extends GetxController {
  final searchTextController = TextEditingController();

  int numOfPages = 2;

  final pagingController = PagingController<int, User>(
    firstPageKey: 1,
  );

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) async {
      fetchFollowings(pageKey);
    });
    super.onInit();
  }

  Future<void> fetchFollowings(int pageKey) async {
    try {
      final followersNewPage = await fetchFollowingsService(pageKey);

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

  void search() {}

  Future<bool> unFollow(String id) async {
    return await unFollowService(id);
  }

  goToUserProfile(User following) {
    Get.toNamed(
      Routes.PROFILE,
      arguments: following,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:instagram_clone/app/models/user.dart';

import '../services/get_following_service.dart';

class FollowingController extends GetxController {
  final searchTextController = TextEditingController();

  int numOfPages = 1;
  int setNumOfPages = 1;
  int totalNumOfProducts = 1;

  final pagingController = PagingController<int, User>(
    firstPageKey: 1,
  );

  @override
  void onReady() {
    super.onReady();
    pagingController.addPageRequestListener((pageKey) async {
      fetchFollowers(pageKey);
    });
  }

  Future<void> fetchFollowers(int pageKey) async {
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
}

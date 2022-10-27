import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:instagram_clone/app/models/post.dart';
import 'package:instagram_clone/app/modules/home/services/fetch_posts_service.dart';

class HomeController extends GetxController {
  int numOfPages = 5;
  final pagingController = PagingController<int, Post>(
    firstPageKey: 1,
  );

  final searchTextController = TextEditingController();

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) async {
      fetchPosts(pageKey);
    });
    super.onInit();
  }

  Future<void> fetchPosts(int pageKey) async {
    try {
      log('fetch posts');
      final followersNewPage = await fetchPostsService(pageKey);

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
}

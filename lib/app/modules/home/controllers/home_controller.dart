
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:instagram_clone/app/models/post.dart';
import 'package:instagram_clone/app/modules/home/services/fetch_posts_service.dart';

class HomeController extends GetxController {
  int numOfPages = 5;
  late final PagingController<int, Post> pagingController;

  final searchTextController = TextEditingController();

  @override
  void onInit() {
    pagingController = PagingController<int, Post>(
      getNextPageKey: getNextPageKey,
      fetchPage: fetchPosts,
    );

    super.onInit();
  }

  int? getNextPageKey(PagingState<int, Post> state) {
    int currentPage = state.nextIntPageKey - 1;
    if (currentPage >= numOfPages) {
      return null;
    }

    return state.nextIntPageKey;
  }

  Future<List<Post>> fetchPosts(int pageKey) async {
    try {
      final result = await fetchPostsService(pageKey);
      numOfPages = result.lastPage;
      return result.data;
    } catch (error) {
      // In their custom PagingController, returning [] or rethrowing might be the way they handle errors.
      // Based on the original code, returning [] was the default.
      return [];
    }
  }
}

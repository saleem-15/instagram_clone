import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:instagram_clone/app/models/profile.dart';

import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/app/modules/follows/services/unfollow_service.dart';
import 'package:instagram_clone/app/routes/app_pages.dart';

import '../services/follow_user_service.dart';
import '../services/get_following_service.dart';
import '../services/search_for_following_service.dart';

class FollowingController extends GetxController {
  FollowingController({required this.profile});

  final Profile profile;
  User get user => profile.user;
  String get userId => user.id;

  int numOfPages = 2;

  final pagingController = PagingController<int, User>(
    firstPageKey: 1,
  );

  RxBool isSearchMode = false.obs;
  final searchTextController = TextEditingController();
  RxBool isLoadingResults = false.obs;
  List<User> searchResults = [];
  RxBool showCancelButtonForSearchField = false.obs;

  @override
  void onInit() {
    showCancelButtonAutomatically();
    pagingController.addPageRequestListener((pageKey) async {
      fetchFollowings(pageKey);
    });
    super.onInit();
  }

  Future<void> fetchFollowings(int pageKey) async {
    try {
      final followersNewPage = await fetchFollowingsService(userId, pageKey, followingController: this);

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

  Future<bool> unFollow(String id) async {
    return await unFollowService(id);
  }

  Future<bool> follow(String id) async {
    return await followService(id);
  }

  void goToUserProfile(User following) {
    Get.toNamed(
      Routes.PROFILE,
      arguments: following,
      parameters: {'user_id': following.id},
    );
  }

  void showCancelButtonAutomatically() {
    searchTextController.addListener(() {
      ///if the search field has text inside it
      if (searchTextController.text.isNotEmpty) {
        showCancelButtonForSearchField(true);
      }
    });
  }

  Future<void> search() async {
    isSearchMode(true);
    final searchKeyWord = searchTextController.text.trim();
    isLoadingResults(true);
    searchResults = await searchForFollowingService(userId, searchKeyWord);
    isLoadingResults(false);
  }

  void onSearchFieldCancelButtonPressed() {
    searchTextController.clear();
    isSearchMode(false);
    showCancelButtonForSearchField(false);
  }
}

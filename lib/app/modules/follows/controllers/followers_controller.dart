import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:instagram_clone/app/models/profile.dart';

import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/app/modules/follows/services/search_for_follower_service.dart';
import 'package:instagram_clone/app/routes/app_pages.dart';

import '../services/follow_user_service.dart';
import '../services/get_followers_service.dart';
import '../services/unfollow_service.dart';

class FollowersController extends GetxController {
  FollowersController({required this.profile});

  int numOfPages = 1;
  int setNumOfPages = 1;
  int totalNumOfProducts = 1;

  final Profile profile;
  User get user => profile.user;
  String get userId => user.id;

  final pagingController = PagingController<int, User>(
    firstPageKey: 1,
  );

  RxBool isSearchMode = false.obs;
  RxBool isLoadingResults = false.obs;
  final searchTextController = TextEditingController();
  List<User> searchResults = [];
  RxBool showCancelButtonForSearchField = false.obs;

  @override
  onInit() {
    showCancelButtonAutomatically();
    pagingController.addPageRequestListener((pageKey) async {
      fetchFollowers(pageKey);
    });
    super.onInit();
  }

  void showCancelButtonAutomatically() {
      searchTextController.addListener(() {
      ///if the search field has text inside it
      if (searchTextController.text.isNotEmpty) {
        showCancelButtonForSearchField(true);
      }
    });
  }

  Future<void> fetchFollowers(int pageKey) async {
    try {
      final followersNewPage = await fetchFollowersService(userId, pageKey, followersController: this);

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
      parameters: {'user_id': following.id},
    );
  }

  Future<void> search() async {
    isSearchMode(true);
    final searchKeyWord = searchTextController.text.trim();
    isLoadingResults(true);
    searchResults = await searchForFollowerService(userId, searchKeyWord);
    isLoadingResults(false);
  }

  Future<bool> unFollow(String id) async {
    return await unFollowService(id);
  }

  Future<bool> follow(String id) async {
    return await followService(id);
  }

  void onSearchFieldCancelButtonPressed() {
    searchTextController.clear();
    isSearchMode(false);
    showCancelButtonForSearchField(false);
  }
}


import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:instagram_clone/core/models/profile.dart';

import 'package:instagram_clone/core/models/user.dart';
import 'package:instagram_clone/features/follows/services/search_for_follower_service.dart';
import 'package:instagram_clone/routes/app_pages.dart';

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

  late final PagingController<int, User> pagingController;

  RxBool isSearchMode = false.obs;
  RxBool isLoadingResults = false.obs;
  final searchTextController = TextEditingController();
  List<User> searchResults = [];
  RxBool showCancelButtonForSearchField = false.obs;

  @override
  onInit() {
    showCancelButtonAutomatically();
    pagingController = PagingController<int, User>(
      getNextPageKey: getNextPageKey,
      fetchPage: fetchFollowers,
    );

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

  int? getNextPageKey(PagingState<int, User> state) {
    int currentPage = state.nextIntPageKey - 1;
    if (currentPage >= numOfPages) {
      return null;
    }

    return state.nextIntPageKey;
  }

  Future<List<User>> fetchFollowers(int pageKey) async {
    try {
      final followersNewPage = await fetchFollowersService(userId, pageKey,
          followersController: this);

      return followersNewPage;
    } catch (error) {

      return [];
    }
  }

  void goToUserProfile(User following) {
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

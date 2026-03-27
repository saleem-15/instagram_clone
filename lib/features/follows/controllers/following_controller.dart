import 'package:instagram_clone/features/follows/services/search_for_following_service.dart';
import 'package:instagram_clone/features/follows/services/follow_user_service.dart';
import 'package:instagram_clone/features/follows/services/unfollow_service.dart';
import 'package:instagram_clone/features/follows/services/get_following_service.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:instagram_clone/core/models/profile.dart';

import 'package:instagram_clone/core/models/user.dart';
import 'package:instagram_clone/routes/app_pages.dart';


class FollowingController extends GetxController {
  FollowingController({required this.profile});

  final Profile profile;
  User get user => profile.user;
  String get userId => user.id;

  int numOfPages = 2;

  late final PagingController<int, User> pagingController;

  RxBool isSearchMode = false.obs;
  final searchTextController = TextEditingController();
  RxBool isLoadingResults = false.obs;
  List<User> searchResults = [];
  RxBool showCancelButtonForSearchField = false.obs;

  @override
  void onInit() {
    showCancelButtonAutomatically();
    pagingController = PagingController<int, User>(
      getNextPageKey: getNextPageKey,
      fetchPage: fetchFollowings,
    );

    super.onInit();
  }

  int? getNextPageKey(PagingState<int, User> state) {
    int currentPage = state.nextIntPageKey - 1;
    if (currentPage >= numOfPages) {
      return null;
    }

    return state.nextIntPageKey;
  }

  Future<List<User>> fetchFollowings(int pageKey) async {
    try {
      final followersNewPage = await fetchFollowingsService(userId, pageKey,
          followingController: this);

      return followersNewPage;
    } catch (error) {

      return [];
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

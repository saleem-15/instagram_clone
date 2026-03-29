import 'package:instagram_clone/features/search/services/search_service.dart';
import 'package:instagram_clone/core/services/storage_service.dart';

import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:instagram_clone/core/models/user.dart';
import 'package:instagram_clone/routes/app_pages.dart';

class SearchController extends GetxController {
  int numOfPages = 1;
  late final PagingController<int, User> pagingController;

  //
  RxList<User> recentSearches = <User>[].obs;
  // RxList<String> recentSearches = Get.find<StorageService>().getRecentSearchs.obs;

  final searchTextController = TextEditingController();
  String get searchedKeyWord => searchTextController.text.trim();
  final FocusNode searchFoucus = FocusNode();

  final RxBool showResults = false.obs;
  RxBool isLoadingForFirstPage = false.obs;

  @override
  void onInit() {
    searchFoucus.requestFocus();

    pagingController = PagingController<int, User>(
      getNextPageKey: getNextPageKey,
      fetchPage: fetchResults,
    );

    super.onInit();
  }

  @override
  Future<void> onReady() async {
    // for (final userId in Get.find<StorageService>().getRecentSearchs) {
    //   recentSearches.add(await fetchUserService(userId));
    // }
    super.onReady();
  }

  void onRecentSearchTilePressed(String userId) {
    Get.toNamed(
      Routes.PROFILE,
      parameters: {'user_id': userId},
    );
  }

  void deleteSuggestionAtIndex(int index) {
    Get.find<StorageService>().removeSearch(recentSearches[index].id);
    recentSearches.removeAt(index);
  }

  int? getNextPageKey(PagingState<int, User> state) {
    // In v5, pages are stored as List<List<T>>, and keys are stored separately
    // We can use the keys field to determine the next page
    final fetchedPages = state.keys?.length ?? 0;

    if (fetchedPages >= numOfPages) {
      return null; // No more pages
    }

    // Next page key is the number of fetched pages + 1
    return fetchedPages + 1;
  }

  /// makes an api request and returns the list of users
  Future<List<User>> fetchResults(int pageKey) async {
    try {
      final newUsers = await searchService(searchedKeyWord, pageKey);
      return newUsers;
    } catch (error) {
      rethrow;
    }
  }

  /// this method must be called when the user wants to search.
  /// it should be called only once (its not responsible for pagination).
  void search() async {
    if (searchedKeyWord.isBlank!) {
      return;
    }

    // /// store the search to the searches History
    // Get.find<StorageService>().addSearch(searchedKeyWord);

    showResults(true);

    /// dismiss the keyboard
    searchFoucus.unfocus();

    /// resets the pagination controller (deletes old results) (so it paginates for the new search keyword)
    pagingController.refresh();
  }

  @override
  void onClose() {
    searchFoucus.dispose();
    super.onClose();
  }

  void onBackButtonPressed() {
    Get.back();
  }

  void onSearchResultPressed(User user) {
    /// store the search to the searches History
    Get.find<StorageService>().addSearch(user.id);

    Get.toNamed(
      Routes.PROFILE,
      parameters: {'user_id': user.id},
      arguments: user,
    );
  }
}

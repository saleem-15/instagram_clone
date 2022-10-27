import 'dart:developer';

import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/app/routes/app_pages.dart';

import '../../../storage/my_shared_pref.dart';
import '../services/search_service.dart';

class SearchController extends GetxController {
  int numOfPages = 1;
  final pagingController = PagingController<int, User>(
    firstPageKey: 1,
  );

  //
  RxList<User> recentSearches = <User>[].obs;
  // RxList<String> recentSearches = MySharedPref.getRecentSearchs.obs;

  final searchTextController = TextEditingController();
  String get searchedKeyWord => searchTextController.text.trim();
  final FocusNode searchFoucus = FocusNode();

  final RxBool showResults = false.obs;
  RxBool isLoadingForFirstPage = false.obs;

  @override
  void onInit() {
    searchFoucus.requestFocus();
    pagingController.addPageRequestListener((pageKey) async {
      fetchResults(pageKey);
    });

    super.onInit();
  }

  @override
  Future<void> onReady() async {
    // for (final userId in MySharedPref.getRecentSearchs) {
    //   recentSearches.add(await fetchUserService(userId));
    // }
    super.onReady();
  }

  void onRecentSearchTilePressed(String userId) {
    Get.toNamed(
      Routes.PROFILE,
      parameters: {'userId': userId},
    );
  }

  void deleteSuggestionAtIndex(int index) {
    MySharedPref.removeSearch(recentSearches[index].id);
    recentSearches.removeAt(index);
  }

  /// makes an api request and puts the products to the itemsList
  Future<void> fetchResults(int pageKey) async {
    log('fetch results is called');
    try {
      final newProducts = await searchService(searchedKeyWord, pageKey);
      final isLastPage = numOfPages == pageKey;
      isLoadingForFirstPage(false);

      if (isLastPage) {
        pagingController.appendLastPage(newProducts);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newProducts, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
      rethrow;
    }
  }

  /// this method must be called when the user wants to search.
  /// it should be called only once (its not responsible for pagination).
  void search() async {
    log('search is called');

    if (searchedKeyWord.isBlank!) {
      return;
    }

    // /// store the search to the searches History
    // MySharedPref.addSearch(searchedKeyWord);

    showResults(true);

    /// dismiss the keyboard
    searchFoucus.unfocus();

    /// resets the pagination controller  (deletes old results) (so it paginates for the new search keyword)
    pagingController.refresh();

    isLoadingForFirstPage(true);
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
    MySharedPref.addSearch(user.id);

    Get.toNamed(
      Routes.PROFILE,
      // parameters: {'userId': user.id},
      arguments: user,
    );
  }
}

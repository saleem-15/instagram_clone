import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app/routes/app_pages.dart';

enum SelectedPage {
  FollowersView,
  FollowingView,
}

class FollowsTabController extends GetxController with GetSingleTickerProviderStateMixin {
  late final List<Tab> myTabs;
  late TabController tabController;
  late SelectedPage selectedPage;
  int get selectedIndex => selectedPage.name == SelectedPage.FollowersView.name ? 0 : 1;

  // FollowersTabController({this.selectedPage = SelectedPage.FollowingView});

  @override
  void onInit() {
    selectedPage = SelectedPage.FollowersView;
    log('FollowersTabController ==> on init');

    myTabs = [
      Tab(child: Text('$numOfFollowers followers')),
      Tab(child: Text('$numOfFollowing following')),
    ];

    log('selected page ${selectedPage.name}');
    log('selected index $selectedIndex');

    tabController = TabController(
      vsync: this,
      length: myTabs.length,
      initialIndex: selectedIndex,
    );
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  final name = 'Saleem Mahdi';
  final userName = 'saleemmahdi10';

  static void goToFollowersView() {
    // Get.put<FollowersTabController>(
    //   FollowersTabController(selectedPage: SelectedPage.FollowersView),
    // );
    Get.toNamed(Routes.FOLLOWERS, parameters: {'pageIndex': '0'});
  }

  // static void goToFollowingView() {
  //   // Get.put<FollowersTabController>(
  //   //   FollowersTabController(selectedPage: SelectedPage.FollowingView),
  //   // );
  //   Get.toNamed(
  //     Routes.FOLLOWERS,
  //     parameters: {'pageIndex': '1'},
  //   );
  // }

  //! temporary variables (must remove them)
  final int numOfFollowers = 12;
  final int numOfFollowing = 33;

}

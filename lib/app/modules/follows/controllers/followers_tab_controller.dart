import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:instagram_clone/app/models/user.dart';

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

  late int numOfFollowers;
  late int numOfFollowing;

  late final String userName;

  @override
  void onInit() {
    selectedPage = SelectedPage.FollowersView;

    numOfFollowers = int.parse(Get.parameters['numOfFollowers']!);
    numOfFollowing = int.parse(Get.parameters['numOfFollowing']!);
    userName = (Get.arguments as User).userName;

    myTabs = [
      Tab(child: Text('$numOfFollowers followers')),
      Tab(child: Text('$numOfFollowing following')),
    ];

    tabController = TabController(
      vsync: this,
      length: myTabs.length,
      initialIndex: selectedIndex,
    );
    super.onInit();
  }

  static void goToFollowersView() {
    Get.toNamed(
      Routes.FOLLOWERS,
      parameters: {'pageIndex': '0'},
    );
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:instagram_clone/app/models/profile.dart';
import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/app/modules/follows/controllers/followers_controller.dart';
import 'package:instagram_clone/app/modules/follows/controllers/following_controller.dart';

import 'package:instagram_clone/app/routes/app_pages.dart';

class FollowsTabController extends GetxController with GetSingleTickerProviderStateMixin {
  late final List<Tab> myTabs;
  late TabController tabController;
  late int selectedIndex;

  late int numOfFollowers;
  late int numOfFollowing;

  Profile get profile => Get.arguments;
  User get user => profile.user;
  String get userName => user.userName;

  /// this method must be called before followers/following screen is opened
  void updateProfile(Profile profile) {
    numOfFollowers = profile.numOfFollowers;
    numOfFollowing = profile.numOfFollowings;

    if (Get.isRegistered<FollowersController>()) {
      Get.find<FollowersController>().pagingController.refresh();
    }
    if (Get.isRegistered<FollowingController>()) {
      Get.find<FollowingController>().pagingController.refresh();
    }
  }

  @override
  void onInit() {
    final Profile profile = Get.arguments;
    selectedIndex = int.parse(Get.parameters['page_index']!);

    numOfFollowers = profile.numOfFollowers;
    numOfFollowing = profile.numOfFollowings;

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

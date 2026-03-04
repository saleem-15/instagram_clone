import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:instagram_clone/app/models/profile.dart';
import 'package:instagram_clone/app/models/user.dart';

import 'package:instagram_clone/app/routes/app_pages.dart';

class FollowsTabController extends GetxController with GetSingleTickerProviderStateMixin {
  FollowsTabController({required this.profile, required this.tab});

  late final List<Tab> myTabs;
  late TabController tabController;
  String tab;
  late int selectedIndex;

  Profile profile;
  int get numOfFollowers => profile.numOfFollowers;
  int get numOfFollowing => profile.numOfFollowings;
  User get user => profile.user;
  String get userName => user.userName;

  @override
  void onInit() {
    selectedIndex = tab == Routes.FOLLOWERS ? 0 : 1;

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

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}

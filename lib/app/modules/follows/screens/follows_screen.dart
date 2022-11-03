import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:instagram_clone/app/models/profile.dart';

import '../controllers/follows_tab_controller.dart';
import '../views/followers_tab.dart';
import '../views/following_tab.dart';

class FollowsScreen extends StatelessWidget {
  FollowsScreen({Key? key, required String tab}) : super(key: key) {
    final Profile profile = Get.arguments;
    controller = Get.put(
      FollowsTabController(
        profile: profile,
        tab: tab,
      ),
      tag: profile.userId,
    );
  }

  late final FollowsTabController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.userName,
        ),
        bottom: TabBar(
          controller: controller.tabController,
          labelStyle: Theme.of(context).textTheme.bodyText1,
          tabs: [
            Tab(
              child: Text('${controller.numOfFollowers} followers'),
            ),
            Tab(
              child: Text('${controller.numOfFollowing} following'),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: [
          FollowersView(profile: controller.profile),
          FollowingView(profile: controller.profile),
        ],
      ),
    );
  }
}

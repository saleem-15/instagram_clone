import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/followers_tab_controller.dart';
import '../views/followers_view.dart';
import '../views/following_view.dart';

class FollowsScreen extends GetView<FollowsTabController> {
  const FollowsScreen({Key? key}) : super(key: key);

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
        children: const [
          FollowersView(),
          FollowingView(),
        ],
      ),
    );
  }
}

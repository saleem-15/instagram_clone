import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:instagram_clone/app/shared/search_field.dart';

import '../controllers/followers_tab_controller.dart';
import 'following_tile_view.dart';

class FollowingView extends GetView<FollowsTabController> {
  const FollowingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchTextField(
          onEditingComplete: controller.search,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) => const FollowingTileView(),
          ),
        ),
      ],
    );
  }
}

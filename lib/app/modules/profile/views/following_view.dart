import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:instagram_clone/app/shared/search_field.dart';

import '../controllers/following_controller.dart';
import 'following_tile.dart';

class FollowingView extends GetView<FollowingController> {
  const FollowingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchTextField(
          textController: controller.searchTextController,
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

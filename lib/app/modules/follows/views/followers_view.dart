import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/app/shared/search_field.dart';

import '../controllers/followers_controller.dart';
import 'follower_tile.dart';

class FollowersView extends GetView<FollowersController> {
  const FollowersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pagingController = controller.pagingController;

    return Column(
      children: [
        SearchTextField(
          textController: controller.searchTextController,
          onEditingComplete: controller.search,
        ),
        Expanded(
          child: PagedListView(
            pagingController: pagingController,
            builderDelegate: PagedChildBuilderDelegate<User>(
              itemBuilder: (context, follower, index) => FollowerTileView(follower: follower),
              firstPageErrorIndicatorBuilder: (context) => Text(pagingController.error.toString()),
              noItemsFoundIndicatorBuilder: (context) => Center(
                child: Text(
                  'you dont have any followers',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              newPageErrorIndicatorBuilder: (context) => const Text('coludnt load'),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/app/shared/loading_widget.dart';
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
              //
              itemBuilder: (_, follower, __) => FollowerTileView(follower: follower),
              //
              firstPageErrorIndicatorBuilder: (_) => errorWidget(),
              //
              noItemsFoundIndicatorBuilder: (context) => noFollowersFoundWidget(context),
              //
              firstPageProgressIndicatorBuilder: (_) => loadingWidget(),
              //
              newPageProgressIndicatorBuilder: (_) => loadingWidget(),
              //
              newPageErrorIndicatorBuilder: (_) => errorWidget(),
            ),
          ),
        ),
      ],
    );
  }

  Center noFollowersFoundWidget(BuildContext context) {
    return Center(
      child: Text(
        'There isn\'t any followers',
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget loadingWidget() => const Center(
        child: LoadingWidget(),
      );

  Widget errorWidget() => Center(
        child: Text(
          controller.pagingController.error.toString(),
        ),
      );
}

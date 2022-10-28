import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/app/shared/loading_widget.dart';
import 'package:instagram_clone/app/shared/search_field.dart';

import '../controllers/following_controller.dart';
import 'following_tile.dart';

class FollowingView extends GetView<FollowingController> {
  const FollowingView({Key? key}) : super(key: key);
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
              itemBuilder: (context, following, index) => FollowingTile(following: following),
              //
              firstPageErrorIndicatorBuilder: (_) => errorWidget(),
              //
              noItemsFoundIndicatorBuilder: (context) => noFollowingsFoundWidget(context),
              //
              firstPageProgressIndicatorBuilder: (_) => loadingWidget(),
              //
              newPageProgressIndicatorBuilder: (context) => loadingWidget(),
              //
              newPageErrorIndicatorBuilder: (_) => errorWidget(),
            ),
          ),
        ),
      ],
    );
  }

  Widget noFollowingsFoundWidget(BuildContext context) {
    return Center(
      child: Text(
        'There isn\'t any followings',
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

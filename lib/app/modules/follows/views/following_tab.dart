import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:instagram_clone/app/models/profile.dart';

import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/app/shared/loading_widget.dart';
import 'package:instagram_clone/app/shared/search_field.dart';

import '../controllers/following_controller.dart';
import 'following_tile.dart';

class FollowingView extends StatelessWidget {
  FollowingView({Key? key, required Profile profile}) : super(key: key) {
    controller = Get.put(
      FollowingController(profile: profile),
      tag: profile.userId,
    );
  }

  late final FollowingController controller;

  @override
  Widget build(BuildContext context) {
    final pagingController = controller.pagingController;

    return Obx(
      () => Column(
        children: [
          SearchTextField(
            textController: controller.searchTextController,
            onEditingComplete: controller.search,
            showCancelButton: controller.showCancelButtonForSearchField.value,
            onCancelButtonPressed: controller.onSearchFieldCancelButtonPressed,
          ),
          if (controller.isSearchMode.value)
            Expanded(
              child: controller.isLoadingResults.isTrue
                  ?

                  /// loading search results
                  const Center(
                      child: LoadingWidget(),
                    )
                  :
                  /// there is no results
                   controller.searchResults.isEmpty
                      ? Center(
                          child: Text(
                            'There is no results',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        )
                      :

                      /// search results
                      ListView.builder(
                          itemCount: controller.searchResults.length,
                          itemBuilder: (_, index) => FollowingTile(
                            following: controller.searchResults[index],
                            controller: controller,
                          ),
                        ),
            ),

          /// followings list (normal mode)
          if (!controller.isSearchMode.value)
            Expanded(
              child: PagedListView(
                pagingController: pagingController,
                builderDelegate: PagedChildBuilderDelegate<User>(
                  //
                  itemBuilder: (context, following, index) => FollowingTile(
                    following: following,
                    controller: controller,
                  ),
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
      ),
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

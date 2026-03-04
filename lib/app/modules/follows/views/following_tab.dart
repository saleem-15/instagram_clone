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
  FollowingView({super.key, required Profile profile}) {
    controller = Get.put(
      FollowingController(profile: profile),
      tag: profile.userId,
    );
  }

  late final FollowingController controller;

  @override
  Widget build(BuildContext context) {
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
                            style: Theme.of(context).textTheme.titleLarge,
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
              child: PagingListener<int, User>(
                controller: controller.pagingController,
                builder: (context, state, fetchNextPage) => PagedListView(
                  state: state,
                  fetchNextPage: fetchNextPage,
                  builderDelegate: PagedChildBuilderDelegate<User>(
                    //
                    itemBuilder: (context, following, index) => FollowingTile(
                      following: following,
                      controller: controller,
                    ),
                    //
                    firstPageErrorIndicatorBuilder: (_) => errorWidget(state),
                    //
                    noItemsFoundIndicatorBuilder: (context) =>
                        noFollowingsFoundWidget(context),
                    //
                    firstPageProgressIndicatorBuilder: (_) => loadingWidget(),
                    //
                    newPageProgressIndicatorBuilder: (context) =>
                        loadingWidget(),
                    //
                    newPageErrorIndicatorBuilder: (_) => errorWidget(state),
                  ),
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
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget loadingWidget() => const Center(
        child: LoadingWidget(),
      );

  Widget errorWidget(PagingState state) => Center(
        child: Text(
          state.error?.toString() ?? 'Error loading followings',
        ),
      );
}

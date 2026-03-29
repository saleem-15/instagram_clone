import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:instagram_clone/core/models/user.dart';
import 'package:instagram_clone/shared/no_items_found_widget.dart';

import '../../controllers/search_controller.dart';
import 'search_result_tile.dart';

class Results extends GetView<SearchController> {
  const Results({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PagingListener<int, User>(
            controller: controller.pagingController,
            builder: (context, state, fetchNextPage) => PagedListView(
              state: state,
              fetchNextPage: fetchNextPage,
              builderDelegate: PagedChildBuilderDelegate<User>(
                itemBuilder: (_, user, __) => SearchResultTile(user: user),

                /// No result state
                noItemsFoundIndicatorBuilder: (_) => noResultsWidget(context),

                /// Searching state
                firstPageProgressIndicatorBuilder: (context) =>
                    searchingWidget(context, controller),

                /// first page Error state
                firstPageErrorIndicatorBuilder: (_) =>
                    Text(state.error?.toString() ?? 'Error loading results'),

                /// Error state
                newPageErrorIndicatorBuilder: (_) =>
                    const Text('Error, couldnt load'),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget noResultsWidget(BuildContext context) {
    return NoItemsFoundWidget(
      icon: CupertinoIcons.search,
      title: 'No Results Found',
      message: 'Try searching for another keyword or username.',
    );
  }
}

Widget searchingWidget(BuildContext context, SearchController controller) {
  return Align(
    alignment: const Alignment(0, -.8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 15.sp,
          width: 15.sp,
          child: const CircularProgressIndicator(strokeWidth: 3),
        ),
        SizedBox(
          width: 20.w,
        ),
        Text(
          'Searching for "${controller.searchedKeyWord}"...',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).disabledColor,
              ),
        ),
      ],
    ),
  );
}

import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:instagram_clone/app/models/user.dart';

import '../controller/search_controller.dart';
import '../views/search_result_tile.dart';

class Results extends GetView<SearchController> {
  const Results({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pagingController = controller.pagingController;
    return Column(
      children: [
        Expanded(
          child: PagedListView(
            pagingController: pagingController,
            builderDelegate: PagedChildBuilderDelegate<User>(
              itemBuilder: (_, user, __) =>
                  SearchResultTile(user: user),

              /// No result state
              noItemsFoundIndicatorBuilder: (_) =>
                  noResultsWidget(context),

              /// Searching state
              firstPageProgressIndicatorBuilder: (context) =>
                  searchingWidget(context, controller),

              /// first page Error state
              firstPageErrorIndicatorBuilder: (_) =>
                  Text(pagingController.error.toString()),

              /// Error state
              newPageErrorIndicatorBuilder: (_) =>
                  const Text('Error, coludnt load'),
            ),
          ),
        ),
      ],
    );
  }

  Widget noResultsWidget(BuildContext context) {
    return Center(
      child: Text(
        'No result were found'.tr,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}

Widget searchingWidget(
    BuildContext context, SearchController controller) {
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

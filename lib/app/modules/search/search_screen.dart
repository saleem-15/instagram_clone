import 'package:flutter/material.dart'hide SearchController;

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app/shared/search_field.dart';

import 'controller/search_controller.dart';
import 'views/results_view.dart';
import 'views/recent_searches_view.dart';

class SearchScreen extends GetView<SearchController> {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///search textField
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: controller.onBackButtonPressed,
                  icon: const Icon(Icons.arrow_back_rounded),
                ),
                Expanded(
                  child: SearchTextField(
                    onEditingComplete: controller.search,
                    textController: controller.searchTextController,
                    focusNode: controller.searchFoucus,
                    showSearchIcon: false,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.sp,
            ),
            Expanded(
              child: Obx(
                ///the focus of the textField is removed when the user clicks (search)
                () => controller.showResults.isTrue ? const Results() : const RecentSearches(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

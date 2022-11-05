import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/config/theme/light_theme_colors.dart';

import '../controller/search_controller.dart';

class RecentSearches extends GetView<SearchController> {
  const RecentSearches({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See All'.tr,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(color: LightThemeColors.lightBlue),
                ),
              ),
            ],
          ).paddingSymmetric(
            horizontal: 15.w,
          ),
          // Expanded(
          //   child: Obx(
          //     () => ListView.builder(
          //       itemCount: controller.recentSearches.length,
          //       itemBuilder: (_, index) => RecentSearchTile(
          //         index: index,
          //         user: User(
          //           id: '$index',
          //           userName: 'userName',
          //           nickName: 'nick name',
          //           image: 'image',
          //           doIFollowHim: false,
          //         ),
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:instagram_clone/app/shared/search_field.dart';
import 'package:instagram_clone/config/theme/light_theme_colors.dart';

import '../controllers/explorer_controller.dart';

class ExplorerView extends GetView<ExplorerController> {
  const ExplorerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// search box (not a text field)
            Container(
              height: 40.sp,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 15.sp, left: 10.w, right: 10.w),
              decoration: BoxDecoration(
                color: lightGrey,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 10.w,
                  ),
                  FaIcon(
                    FontAwesomeIcons.magnifyingGlass,
                    size: 15.sp,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    'Search',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Theme.of(context).disabledColor,
                        ),
                  ),
                ],
              ),
            ),

            SearchTextField(
              onEditingComplete: controller.search,
            )
          ],
        ),
      ),
    );
  }
}

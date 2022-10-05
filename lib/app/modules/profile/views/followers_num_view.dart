import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:instagram_clone/app/modules/profile/controllers/followers_controller.dart';

import '../../../../config/theme/light_theme_colors.dart';

class FollowersNumView extends GetView<FollowersController> {
  const FollowersNumView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            controller.userName,
          ),
          bottom: TabBar(
            labelStyle: Theme.of(context).textTheme.bodyText1,
            tabs: [
              Tab(
                child: Text('${controller.numOfFollowers} followers'),
              ),
              Tab(
                child: Text('${controller.numOfFollowing} following'),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            SearchTextField(),
            Center(child: Text('2')),
          ],
        ),
      ),
    );
  }
}

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                color: Theme.of(context).disabledColor,
                size: 15.sp,
              ),
              SizedBox(
                width: 10.w,
              ),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration.collapsed(hintText: 'Search'),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

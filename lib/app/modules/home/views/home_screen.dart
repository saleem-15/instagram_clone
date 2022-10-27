import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:instagram_clone/app/models/post.dart';
import 'package:instagram_clone/app/modules/home/views/stories_view.dart';
import 'package:instagram_clone/app/modules/posts/views/post_view.dart';

import '../controllers/home_controller.dart';

// ignore_for_file: prefer_const_constructors

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pagingController = controller.pagingController;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/icons/instagram-word-logo-removebg.png',
          width: 120.sp,
        ),
      ),
      body:
          //  pagingController.itemList == null || pagingController.itemList == 0
          //     ? StoriesView()
          //     :
          PagedListView<int, Post>(
        pagingController: pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          itemBuilder: (context, post, index) {
            if (index == 0) {
              return Column(
                children: [
                  StoriesView(),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.only(bottom: 3.sp),
                    child: PostView(
                      post: post,
                    ),
                  ),
                ],
              );
            }

            return Padding(
              padding: EdgeInsets.only(bottom: 3.sp),
              child: PostView(
                post: post,
              ),
            );
          },
          firstPageErrorIndicatorBuilder: (context) =>
              Text(controller.pagingController.error.toString()),
          noItemsFoundIndicatorBuilder: (context) => Center(
            child: Text(
              'No Posts was Found'.tr,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          newPageErrorIndicatorBuilder: (context) => const Text('coludnt load'),
        ),
      ),
    );
  }
}

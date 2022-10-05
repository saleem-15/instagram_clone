// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'post_view.dart';
import 'stories_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/icons/instagram-word-logo-removebg.png',
          width: 120.sp,
        ),
      ),
      body: Column(
        children: [
          const StoriesView(),
          Expanded(
            child: ListView.builder(
              itemCount: controller.posts.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(top: 3.sp),
                child: PostView(
                  post: controller.posts[index],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/stories_controller.dart';
import '../views/user_story_view.dart';

const STORY_SCAFFOLD_COLOR = Colors.black;

class StoryScreen extends StatelessWidget {
  StoryScreen({Key? key}) : super(key: key);

  /// the person that the user has pressed its story tile
  final int pressedUserIndex = int.parse(Get.parameters['pressed_user_index']!);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    final usersStoriesController = Get.find<StoriesController>();
    final stories = usersStoriesController.stories;

    return Scaffold(
      /// dont change scaffold size when the keyboard opens
      resizeToAvoidBottomInset: false,
      backgroundColor: STORY_SCAFFOLD_COLOR,
      body: SafeArea(
        child: CarouselSlider.builder(
          initialPage: pressedUserIndex,

          /// transition animation duration
          autoSliderTransitionTime: const Duration(milliseconds: 700),
          controller: usersStoriesController.carouselSliderController,
          itemCount: stories.length,
          slideTransform: const CubeTransform(),
          slideBuilder: (index) => UserStoriesView(
            user: stories[index],
          ),
        ).marginOnly(top: 5.sp),
      ),
    );
  }
}

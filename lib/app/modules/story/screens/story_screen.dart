// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app/models/user.dart';

import '../controllers/stories_controller.dart';
import '../views/user_story_view.dart';

const STORY_SCAFFOLD_COLOR = Colors.black;

class StoryScreen extends StatelessWidget {
  StoryScreen({Key? key}) : super(key: key) {
    if (Get.parameters['pressed_user_index'] != null) {
      pressedUserIndex =
          int.parse(Get.parameters['pressed_user_index']!);
    } else {
      pressedUserIndex = null;
    }

    user = Get.arguments;
  }

  /// the person that the user has pressed its story tile
  /// if its null then this story screen is not opened from
  /// the (story view)  (in the home screen)
  /// which means this story is probably for a user that you dont follow
  late final int? pressedUserIndex;
  late final User user;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    final usersStoriesController = Get.find<StoriesController>();
    final stories = usersStoriesController.stories;
    final double topViewPadding =
        MediaQuery.of(context).viewPadding.top;
    final double topMargin =
        topViewPadding > 40 ? 40 : topViewPadding;
    return Scaffold(
      /// dont change scaffold size when the keyboard opens
      resizeToAvoidBottomInset: false,
      backgroundColor: STORY_SCAFFOLD_COLOR,
      body: CarouselSlider.builder(
        initialPage: pressedUserIndex ?? 0,

        /// transition animation duration
        autoSliderTransitionTime: const Duration(milliseconds: 700),
        controller: usersStoriesController.carouselSliderController,
        itemCount: pressedUserIndex == null ? 1 : stories.length,
        slideTransform: const CubeTransform(),
        slideBuilder: (index) => UserStoriesView(
          user: pressedUserIndex == null ? user : stories[index],
          userIndex: index,
        ),
      ).marginOnly(top: topMargin),
    );
  }
}

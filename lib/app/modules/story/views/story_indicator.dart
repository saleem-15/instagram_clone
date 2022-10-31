// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/config/theme/colors.dart';

import '../controllers/sotry_indicator_controller.dart';
import '../controllers/user_story_controller.dart';

final horizontalMarginBetweenStroyIndicator = 1.5.sp;
final double STORY_INDICATOR_HORIZONTAL_MARGIN = 5.w;
final screenWidth = 360.w;

class StoryProgressIndicator extends StatelessWidget {
  StoryProgressIndicator({
    Key? key,
    required this.userStoryController,
  }) : super(key: key) {
    storyIndicatorController = userStoryController.storyIndicatorController;
  }

  final UserStoryController userStoryController;
  String get userId => userStoryController.user.id;
  late final StoryIndicatorController storyIndicatorController;

  @override
  Widget build(BuildContext context) {
    final indicatorMargin = EdgeInsets.symmetric(
      horizontal: horizontalMarginBetweenStroyIndicator,
    );

    final indicatorRadius = BorderRadius.circular(5.sp);
    log('current index: ${userStoryController.currentStoryIndex}');

    return SizedBox(
      width: screenWidth - STORY_INDICATOR_HORIZONTAL_MARGIN * 2,
      height: 2.sp,
      child: Row(
        children: List.generate(
          userStoryController.storiesList.length,
          (index) {
            return Expanded(
              child: Stack(
                children: [
                  Container(
                    margin: indicatorMargin,
                    decoration: BoxDecoration(
                      color: MyColors.UNWATCHED_STORY_INDICATOR_COLOR,
                      borderRadius: indicatorRadius,
                    ),
                  ),
                  GetBuilder<UserStoryController>(
                    tag: userId,
                    assignId: true,
                    id: 'story media',
                    builder: (controller) {
                      log('indicator is updated');

                      /// if its already wathced AND its not currently being reWathced
                      /// then display that its wathced
                      if (userStoryController.storiesList[index].isWathced &&
                          userStoryController.currentStoryIndex > index) {
                        return Container(
                          margin: indicatorMargin,
                          width: storyIndicatorController.maxSingleIndicatorWidth,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: indicatorRadius,
                          ),
                        );
                      }

                      /// if this story is being watched
                      if (userStoryController.currentStoryIndex == index) {
                        return AnimatedBuilder(
                          animation: storyIndicatorController.animationController,
                          builder: (_, __) {
                            return Container(
                              margin: indicatorMargin,
                              width: storyIndicatorController.animationController.value,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: indicatorRadius,
                              ),
                            );
                          },
                        );
                      }

                      /// if this story is not watched
                      /// AND
                      /// Its not being wathed
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

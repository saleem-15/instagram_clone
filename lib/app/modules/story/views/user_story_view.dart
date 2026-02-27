// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:holding_gesture/holding_gesture.dart';
import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/app/modules/story/controllers/user_story_controller.dart';
import 'package:instagram_clone/app/shared/user_avatar.dart';

import '../views/story_indicator.dart';
import '../views/story_media.dart';

class UserStoriesView extends StatelessWidget {
  UserStoriesView({
    Key? key,
    required this.user,
    required int userIndex,
    // required this.controller,
  }) : super(key: key) {
    controller =
        Get.put(UserStoryController(user, userIndex), tag: user.id);
  }

  final User user;

  // final UserStoryController controller;
  bool isFirstBuild = true;
  late final UserStoryController controller;

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible =
        MediaQuery.of(context).viewInsets.bottom != 0;

    if (isKeyboardVisible) {
      controller.pauseStory();
    }
    if (!isKeyboardVisible && !isFirstBuild) {
      controller.resumeStory();
      isFirstBuild = false;
    }

    return Stack(
      children: [
        /// story media (photo/video) && user info && story indicator
        Positioned.fill(
          child: Stack(
            children: [
              /// progress indicator at the top

              StoryMedia(storyController: controller),

              /// 2 gestures (right & left side )
              Positioned.fill(
                child: Row(
                  children: [
                    Expanded(
                      child: HoldDetector(
                        onTap: () {
                          log('onTap');
                          controller.goToPreviousStory();
                        },
                        onHold: controller.onHold,
                        onCancel: controller.onHoldEnds,
                        child: const SizedBox.expand(),
                        // onTapDown: controller.onTapDown,
                        // onTapUp: controller.onTapUp,
                      ),
                    ),
                    Expanded(
                      child: HoldDetector(
                        onTap: () {
                          log('onTap');
                          controller.goToNextStory();
                        },
                        onHold: controller.onHold,
                        onCancel: controller.onHoldEnds,
                        child: const SizedBox.expand(),

                        // onTapDown: controller.onTapDown,
                        // onTapUp: controller.onTapUp,
                      ),
                    ),
                  ],
                ),
              ),

              /// user avater and name
              Positioned(
                top: 20.sp,
                left: 15.w,
                child: Row(
                  children: [
                    UserAvatar.story(
                      user: controller.user,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        log('name');
                        controller.onUserNamePressed;
                      },
                      child: Text(
                        controller.user.userName,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(
                              color: Colors.white.withValues(alpha:.9),
                            ),
                      ).paddingSymmetric(vertical: 5.sp),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),

                    /// when the story was posted
                    Text(
                      '14 h',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(
                            color: Colors.white38,
                          ),
                    ),
                  ],
                ),
              ),

              /// story indicator
              Positioned(
                top: 10.sp,
                right: STORY_INDICATOR_HORIZONTAL_MARGIN,
                left: STORY_INDICATOR_HORIZONTAL_MARGIN,
                child: StoryProgressIndicator(
                  userStoryController: controller,
                ),
              ),
            ],
          ).marginOnly(
            top: 10.h,
            bottom: 68.h,
          ),
        ),

        /// overly when the keyboard is visible
        if (isKeyboardVisible)
          Positioned.fill(
            child: Container(color: Colors.black54),
          ),

        /// textField
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            padding: EdgeInsets.symmetric(
                horizontal: 5.w, vertical: 20.sp),
            child: TextField(
              style: TextStyle(color: Colors.white.withValues(alpha:.85)),
              cursorColor: Colors.greenAccent,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15.sp),
                filled: false,
                hintText: 'Send message',
                hintStyle: const TextStyle(color: Colors.white),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white30),
                  borderRadius:
                      BorderRadius.all(Radius.circular(25.r)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white30),
                  borderRadius:
                      BorderRadius.all(Radius.circular(25.r)),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
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

class StoryScreen extends StatelessWidget {
  StoryScreen({
    Key? key,
  }) : super(key: key) {
    final User user = Get.arguments;
    controller = Get.put(UserStoryController(user), tag: user.id);
  }

  late final UserStoryController controller;

  @override
  Widget build(BuildContext context) {
    const Color scaffoldColor = Color.fromARGB(255, 17, 17, 17);
    return Scaffold(
      /// dont change scaffold size when the keyboard opens
      resizeToAvoidBottomInset: false,
      backgroundColor: scaffoldColor,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: Stack(
            children: [
              /// story media (photo/video) && user info && story indicator
              Positioned.fill(
                child: Stack(
                  children: [
                    /// progress indicator at the top

                    StoryMedia(storyController: controller),

                    /// user avater and name
                    Positioned(
                      top: 20.sp,
                      left: 15.w,
                      child: Row(
                        children: [
                          UserAvatar(
                            user: controller.user,
                            showRingIfHasStory: false,
                            size: 20,
                            backGroundColor: scaffoldColor,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          GestureDetector(
                            onTap: () => controller.onUserNamePressed,
                            child: Text(
                              controller.user.userName,
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.white.withOpacity(.9),
                                  ),
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),

                          /// when the story was posted
                          Text(
                            '14 h',
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(
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
                        onHold: controller.onTapDown,
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
                        onHold: controller.onTapDown,
                        onCancel: controller.onHoldEnds,
                        child: const SizedBox.expand(),

                        // onTapDown: controller.onTapDown,
                        // onTapUp: controller.onTapUp,
                      ),
                    ),
                  ],
                ),
              ),

              /// textField
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 20.sp),
                  child: TextField(
                    style: TextStyle(color: Colors.white.withOpacity(.85)),
                    cursorColor: Colors.greenAccent,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 15.sp),
                      filled: false,
                      hintText: 'Send message',
                      hintStyle: const TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white30),
                        borderRadius: BorderRadius.all(Radius.circular(25.r)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white30),
                        borderRadius: BorderRadius.all(Radius.circular(25.r)),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

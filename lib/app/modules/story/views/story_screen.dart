import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/app/shared/user_avatar.dart';

import '../controllers/story_controller.dart';

class StoryScreen extends GetView<StoryController> {
  const StoryScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;
  @override
  Widget build(BuildContext context) {
    log('story is build viewInsets.bottom = ${MediaQuery.of(context).viewInsets.bottom}');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 17, 17, 17),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset('assets/images/post_image.jpg'),
                    ),
                    Positioned(
                      top: 20.sp,
                      left: 15.w,
                      child: Row(
                        children: [
                          UserAvatar(
                            user: user,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            user.userName,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.white.withOpacity(.9),
                                    ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),

                          /// when the story was posted
                          Text(
                            '14 h',
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      color: Colors.white38,
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 5.sp),
                        child: TextField(
                          style:
                              TextStyle(color: Colors.white.withOpacity(.85)),
                          cursorColor: Colors.greenAccent,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15.sp),
                            filled: false,
                            hintText: 'Send message',
                            hintStyle: const TextStyle(color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.white30),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.r)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.white30),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.r)),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

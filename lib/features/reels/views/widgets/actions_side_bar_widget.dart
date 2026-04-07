import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/shared/animated_love_button.dart';

import '../../controllers/reel_player_controller.dart';

class ActionsSideBar extends StatelessWidget {
  const ActionsSideBar({
    super.key,
    required this.tag,
    required this.controller,
  });
  final ReelPlayerController controller;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Obx(() => IgnorePointer(
          ignoring: controller.isCommentsOpen.value,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: controller.isCommentsOpen.value ? 0.0 : 1.0,
            child: GetBuilder<ReelPlayerController>(
              tag: tag,
              id: 'actions',
              builder: (cv) {
                const List<Shadow> shadows = [
                  Shadow(
                    blurRadius: 15,
                    color: Colors.black12,
                    offset: Offset(0, 0),
                  ),
                ];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Love Button
                    AnimatedLoveButton(
                      isFavorite: cv.reel.isFavorite,
                      size: 28,
                      onHeartPressed: cv.onHeartPressed,
                    ),
                    // Text(
                    //   '${cv.reel.numOfLikes}',
                    //   style: const TextStyle(
                    //     color: Colors.white,
                    //     shadows: shadows,
                    //   ),
                    // ),
                    const SizedBox(height: 15),

                    // Comment Button
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/icons/comment.svg',
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                        width: 26.sp,
                      ),
                      onPressed: cv.comment,
                    ),
                    // Text(
                    //   '${cv.reel.numOfComments}',
                    //   style: const TextStyle(
                    //     color: Colors.white,
                    //     shadows: shadows,
                    //   ),
                    // ),
                    const SizedBox(height: 15),

                    // Send Button
                    IconButton(
                      icon: Stack(
                        children: [
                          Transform.translate(
                            offset: const Offset(1, 1),
                            child: SvgPicture.asset(
                              'assets/icons/send.svg',
                              colorFilter: const ColorFilter.mode(
                                Colors.black12,
                                BlendMode.srcIn,
                              ),
                              width: 28.sp,
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/icons/send.svg',
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                            width: 28.sp,
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                    const SizedBox(height: 15),

                    // Save Button
                    IconButton(
                      icon: Icon(
                        cv.reel.isSaved
                            ? Icons.bookmark_sharp
                            : Icons.bookmark_outline_sharp,
                        color: Colors.white,
                        size: 28,
                        shadows: shadows,
                      ),
                      onPressed: cv.onSavePressed,
                    ),
                  ],
                );
              },
            ),
          ),
        ));
  }
}

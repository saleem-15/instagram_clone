import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/shared/user_avatar.dart';

import '../../controllers/reel_player_controller.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({
    super.key,
    required this.tag,
    required this.controller,
  });

  final String tag;
  final ReelPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => IgnorePointer(
          ignoring: controller.isCommentsOpen.value,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: controller.isCommentsOpen.value ? 0.0 : 1.0,
            child: GetBuilder<ReelPlayerController>(
              tag: tag,
              id: 'user_info',
              builder: (cv) {
                const List<Shadow> shadows = [
                  Shadow(
                    blurRadius: 10,
                    color: Colors.black12,
                    offset: Offset(0, 0),
                  ),
                ];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // If its not me and I dont follow the user, show follow button
                        if (cv.showFollowButton) ...[
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 7.sp,
                                vertical: 0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              minimumSize: Size(60, 28.sp),
                              backgroundColor: Colors.transparent,
                              side: const BorderSide(color: Colors.white),
                            ),
                            onPressed: cv.onFollowUserPressed,
                            child: Text(
                              cv.reel.user.doIFollowHim
                                  ? 'Following'
                                  : 'Follow',
                              style: TextStyle(
                                color: Colors.white,
                                shadows: shadows,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],

                        Text(
                          cv.reel.user.userName,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                            shadows: shadows,
                          ),
                        ),
                        const SizedBox(width: 10),
                        UserAvatar.follower(
                          user: cv.reel.user,
                          size: 18.sp,
                        ),
                      ],
                    ),
                    if (cv.reel.caption.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                          cv.reel.caption,
                          style: const TextStyle(
                            color: Colors.white,
                            shadows: shadows,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ]
                  ],
                );
              },
            ),
          ),
        ));
  }
}

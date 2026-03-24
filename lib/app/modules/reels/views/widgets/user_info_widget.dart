
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app/shared/user_avatar.dart';

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
              builder: (cv) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // If its not me and I dont follow the user, show follow button
                      if (!cv.reel.user.isMe && !cv.reel.user.doIFollowHim) ...[
                        const SizedBox(width: 10),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            minimumSize: const Size(60, 30),
                            backgroundColor: Colors.transparent,
                            side: const BorderSide(color: Colors.white),
                          ),
                          onPressed: cv.followUser,
                          child: const Text(
                            'Follow',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],

                      Text(
                        cv.reel.user.userName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 10),
                      UserAvatar.follower(
                        user: cv.reel.user,
                        size: 20,
                      ),
                    ],
                  ),
                  if (cv.reel.caption.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        cv.reel.caption,
                        style: const TextStyle(color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ),
        ));
  }
}

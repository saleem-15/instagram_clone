import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/app/modules/story/controllers/stories_controller.dart';
import 'package:instagram_clone/app/routes/app_pages.dart';

enum AvatarMode {
  Comment,
  Profile,
  Follower,
  None,
}

class UserAvatar extends StatelessWidget {
  const UserAvatar.story({
    Key? key,
    required this.user,
    this.size = 20,
    this.showRingIfHasStory = false,
  })  : _avatarMode = AvatarMode.Follower,
        super(key: key);
  const UserAvatar.follower({
    Key? key,
    required this.user,
    this.size = 25,
    this.showRingIfHasStory = true,
  })  : _avatarMode = AvatarMode.Follower,
        super(key: key);

  const UserAvatar.comment({
    Key? key,
    required this.user,
    this.size = 18,
    this.showRingIfHasStory = true,
  })  : _avatarMode = AvatarMode.Comment,
        super(key: key);

  const UserAvatar.userProfile({
    Key? key,
    required this.user,
    this.size = 38,
    this.showRingIfHasStory = true,
  })  : _avatarMode = AvatarMode.Profile,
        super(key: key);

  /// avatar size is in (sp)
  final double size;
  final AvatarMode _avatarMode;

  /// used between the (gradient story ring) and the image of the user,
  /// typically the color of the scaffold
  final User user;
  final bool showRingIfHasStory;
  @override
  Widget build(BuildContext context) {
    const ImageProvider backgroundImage = AssetImage('assets/images/default_user_image.png');
    // final ImageProvider backgroundImage = (user.image == null
    //     ? const AssetImage('assets/images/default_user_image.png')
    //     : NetworkImage(user.image!)) as ImageProvider;

    return GestureDetector(
      onTap: onUserAvatarTapped,
      child: user.isHasNewStory && showRingIfHasStory
          ?

          /// with gradient ring
          Container(
              padding: EdgeInsets.all(_avatarMode == AvatarMode.Comment ? 4.sp : 6.sp),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: user.isHasNewStory
                    ? const DecorationImage(
                        image: AssetImage('assets/icons/story_ring.png'),
                      )
                    : null,
              ),
              child: CircleAvatar(
                radius: size,

                /// before the actual photo of the user loads, put this photo
                backgroundImage: const AssetImage('assets/images/default_user_image.png'),
                child: const Image(image: backgroundImage),
              ),
            )
          :

          /// without gradient ring
          CircleAvatar(
              radius: size,

              /// before the actual photo of the user loads, put this photo
              backgroundImage: const AssetImage('assets/images/default_user_image.png'),

              child: const Image(
                image: backgroundImage,
                // fit: BoxFit.fill,
                // isAntiAlias: true,
              ),
            ),
    );
  }

  /// 1- if the user has unWatched stories then it goes to his stories
  /// Or it will go his profile
  void onUserAvatarTapped() {
    if (user.isHasNewStory) {
      Get.find<StoriesController>().goToUserStories(user);
    }

    if (_avatarMode == AvatarMode.Profile) {
      return;
    }

    if (!user.isHasNewStory) {
      Get.toNamed(
        Routes.PROFILE,
        arguments: user,
        parameters: {'user_id': user.id},
      );
    }
  }
}



      // gradient: LinearGradient(
                //   begin: Alignment.topCenter,
                //   colors: [
                //     Color(0xff515BD4),
                //     Color(0xff8134AF),
                //     Color(0xffDD2A7B),
                //     Color(0xffFEDA77),
                //     Color(0xffF58529),
                //   ],
                // ),
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:instagram_clone/core/models/user.dart';
import 'package:instagram_clone/features/story/controllers/stories_controller.dart';
import 'package:instagram_clone/routes/app_pages.dart';

enum AvatarMode {
  Comment,
  Profile,
  Follower,
  None,
}

class UserAvatar extends StatelessWidget {
  const UserAvatar.story({
    super.key,
    required this.user,
    this.size = 20,
    this.showRingIfHasStory = false,
    this.onTap,
  }) : _avatarMode = AvatarMode.Follower;

  const UserAvatar.follower({
    super.key,
    required this.user,
    this.size = 25,
    this.showRingIfHasStory = true,
    this.onTap,
  }) : _avatarMode = AvatarMode.Follower;

  const UserAvatar.comment({
    super.key,
    required this.user,
    this.size = 18,
    this.showRingIfHasStory = true,
    this.onTap,
  }) : _avatarMode = AvatarMode.Comment;

  const UserAvatar.userProfile({
    super.key,
    required this.user,
    this.size = 38,
    this.showRingIfHasStory = true,
    this.onTap,
  }) : _avatarMode = AvatarMode.Profile;

  /// avatar size is in (sp)
  final double size;
  final AvatarMode _avatarMode;

  /// used between the (gradient story ring) and the image of the user,
  /// typically the color of the scaffold
  final User user;
  final bool showRingIfHasStory;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ImageProvider backgroundImage = user.image == null
        ? const AssetImage('assets/images/default_user_image.png')
        : CachedNetworkImageProvider(user.image!) as ImageProvider;

    return GestureDetector(
      onTap: onTap ?? onUserAvatarTapped,
      child: user.isHasNewStory && showRingIfHasStory
          ? _buildWithStoryRing(backgroundImage)
          : _buildWithoutStoryRing(backgroundImage),
    );
  }

  Widget _buildWithStoryRing(ImageProvider backgroundImage) {
    return Container(
      padding: EdgeInsets.all(_avatarMode == AvatarMode.Comment ? 4.sp : 6.sp),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage('assets/icons/story_ring.png'),
        ),
      ),
      child: _buildAvatar(backgroundImage),
    );
  }

  Widget _buildWithoutStoryRing(ImageProvider backgroundImage) {
    return _buildAvatar(backgroundImage);
  }

  Widget _buildAvatar(ImageProvider backgroundImage) {
    return CircleAvatar(
      radius: size,
      backgroundImage: const AssetImage('assets/images/default_user_image.png'),
      foregroundImage: backgroundImage,
      onForegroundImageError: (exception, stackTrace) {
        debugPrint('User Avatar Image error: ${user.image} \n $exception');
      },
    );
  }

  void onUserAvatarTapped() {
    if (user.isHasNewStory) {
      Get.find<StoriesController>().goToUserStories(user);
    } else if (_avatarMode != AvatarMode.Profile) {
      Get.toNamed(
        Routes.PROFILE,
        arguments: user,
        parameters: {'user_id': user.id},
      );
    }
  }
}
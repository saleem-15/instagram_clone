import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app/shared/user_avatar.dart';
import 'package:instagram_clone/config/theme/light_theme_colors.dart';
import 'package:instagram_clone/config/theme/my_styles.dart';

import '../controllers/profile_controller.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key? key,
    required this.profileController,
  }) : super(key: key);

  final ProfileController profileController;

  @override
  Widget build(BuildContext context) {
    /// vertical space between the number of (post,follower,following) and the text bellow the num
    final verticalSpace = 5.sp;
    final numbersTextStyle = Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16.sp);
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                /// user photo and name
                Column(
                  children: [
                    UserAvatar(
                      userAvatarSize: 35,
                      user: profileController.user,
                      showRingIfHasStory: true,
                    ),
                    SizedBox(
                      height: verticalSpace,
                    ),
                    Text(
                      profileController.profile.nickName,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      /// width, height of each item of the row
                      final size = constraints.maxWidth / 3;
                      return Row(
                        children: [
                          /// post num
                          InkWell(
                            onTap: () {},
                            child: SizedBox(
                              width: size,
                              height: size,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${profileController.profile.numOfPost}',
                                    style: numbersTextStyle,
                                  ),
                                  SizedBox(
                                    height: verticalSpace,
                                  ),
                                  const Text('Posts'),
                                ],
                              ),
                            ),
                          ),

                          /// followers num
                          InkWell(
                            onTap: profileController.goToFollowers,
                            child: SizedBox(
                              width: size,
                              height: size,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${profileController.profile.numOfFollowers}',
                                    style: numbersTextStyle,
                                  ),
                                  SizedBox(
                                    height: verticalSpace,
                                  ),
                                  const Text('Followers'),
                                ],
                              ),
                            ),
                          ),

                          /// following num
                          InkWell(
                            onTap: profileController.goToFollowing,
                            child: SizedBox(
                              width: size,
                              height: size,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${profileController.profile.numOfFollowings}',
                                    style: numbersTextStyle,
                                  ),
                                  SizedBox(
                                    height: verticalSpace,
                                  ),
                                  const Text('Following'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),

            /// bio
            SizedBox(
              height: 2.sp,
            ),
            if (profileController.profile.bio != null) Text(profileController.profile.bio!),
          ],
        ),
        SizedBox(
          height: 10.sp,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 35,
          child: profileController.isMyProfile

              /// edit profile button (only if its my profile)
              ? ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Edit Profile',
                    style: TextStyle(color: LightThemeColors.buttonTextColor),
                  ),
                )

              /// follow/unfollow  button (if its not  my profile)
              :
              //  const Text('is not my profile')
              GetBuilder<ProfileController>(
                  tag: profileController.profile.userId,
                  assignId: true,
                  id: 'do I follow him',
                  builder: (_) {
                    log('do i follow the user ${profileController.profile.userId}: ${profileController.profile.doIFollowHim}');
                    return profileController.profile.doIFollowHim
                        ? ElevatedButton(
                            onPressed: profileController.unFollowUser,
                            child: Text(
                              'Following',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          )
                        : ElevatedButton(
                            style: MyStyles.getAuthButtonStyle(),
                            onPressed: profileController.followUser,
                            child: const Text(
                              'Follow',
                              style: TextStyle(),
                            ),
                          );
                  },
                ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/app/modules/profile/controllers/user_posts_controller.dart';
import 'package:instagram_clone/app/shared/loading_widget.dart';
import 'package:instagram_clone/app/storage/my_shared_pref.dart';

import '../controllers/profile_controller.dart';
import '../views/my_posts_tab.dart';
import '../views/profile_header.dart';
import '../views/floating_avatar_view.dart';
import '../views/profile_mentions_tab.dart';
import '../views/profile_reels_tab.dart';
import '../controllers/profile_reels_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({
    super.key,
  }) {
    /// if userId = null  ==> then its my profile
    final args = Get.arguments;
    user = (args is User) ? args : MySharedPref.getUserData!;
    profileController = Get.put(ProfileController(), tag: user.id);
    userPostsController = Get.put(UserPostsController(), tag: user.id);
    profileReelsController = Get.put(
        ProfileReelsTabController(profileUserId: user.id),
        tag: user.id);
  }

  late final User user;
  late final ProfileController profileController;
  late final UserPostsController userPostsController;
  late final ProfileReelsTabController profileReelsController;

  @override
  Widget build(BuildContext context) {
    final bool isPushed = Navigator.canPop(context);
    return Stack(
      children: [
        /// profile page with all of its components

        Scaffold(
          primary: isPushed,
          appBar: profileAppBar(context, profileController, isPushed),
          body: Obx(
            () => profileController.isLoading.isTrue
                ? const Center(
                    child: LoadingWidget(),
                  )
                : DefaultTabController(
                    length: 3,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 15.w, right: 15.w, bottom: 5, top: 0),
                          child: ProfileHeader(
                              profileController: profileController),
                        ),
                        TabBar(
                          tabs: [
                            Tab(
                              icon: Icon(
                                Icons.grid_on_sharp,
                                size: 22.sp,
                              ),
                            ),
                            Tab(
                              icon: SvgPicture.asset(
                                'assets/icons/Reels.svg',
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context).iconTheme.color!,
                                  BlendMode.srcIn,
                                ),
                                width: 22.sp,
                              ),
                            ),
                            Tab(
                              icon: SvgPicture.asset(
                                'assets/icons/instagram-tag-icon.svg',
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context).iconTheme.color!,
                                  BlendMode.srcIn,
                                ),
                                width: 22.sp,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              ProfilePostsTap(controller: userPostsController),
                              ProfileReelsTab(
                                  controller: profileReelsController),
                              const ProfileMentionsTab(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),

        /// when the user presses on a post the post appear on the top of the page
        // if (controller.isTherePostOnTop) const FloatingPostView(),

        Obx(() {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 150),
            transitionBuilder: (child, animation) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            child: profileController.isAvatarFloating.isTrue
                ? FloatingAvatarView(user: profileController.user)
                : const SizedBox.shrink(),
          );
        }),
      ],
    );
  }

  AppBar profileAppBar(
      BuildContext context, ProfileController controller, bool isPrimary) {
    return AppBar(
      primary: isPrimary,
      title: Text(
        controller.user.userName,
      ),
      actions: [
        Obx(
          () {
            return controller.isLoading.value || !controller.isMyProfile
                ? const SizedBox.shrink()
                : Row(
                    children: [
                      IconButton(
                        onPressed: controller.showAddPostBottomSheet,
                        icon: SvgPicture.asset(
                          'assets/icons/Create.svg',
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).iconTheme.color!,
                            BlendMode.srcIn,
                          ),
                          width: 25.sp,
                        ),
                      ),
                      IconButton(
                        onPressed: controller.showSettingsBottomSheet,
                        icon: const Icon(Icons.menu_rounded),
                      ),
                    ],
                  );
          },
        ),
      ],
    );
  }
}

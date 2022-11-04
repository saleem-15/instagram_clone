import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/app/modules/profile/controllers/user_posts_controller.dart';
import 'package:instagram_clone/app/shared/loading_widget.dart';
import 'package:instagram_clone/app/storage/my_shared_pref.dart';

import '../controllers/profile_controller.dart';
import '../views/my_posts_tab.dart';
import '../views/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({
    Key? key,
  }) : super(key: key) {
    /// if userId = null  ==> then its my profile
    user = Get.arguments ?? MySharedPref.getUserData;
    profileController = Get.put(ProfileController(), tag: user.id);
    userPostsController = Get.put(UserPostsController(), tag: user.id);
  }

  late final User user;
  late final ProfileController profileController;
  late final UserPostsController userPostsController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// profile page with all of its components

        Scaffold(
          appBar: profileAppBar(profileController),
          body: Obx(
            () => profileController.isLoading.isTrue
                ? const Center(
                    child: LoadingWidget(),
                  )
                : DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5),
                          child: ProfileHeader(profileController: profileController),
                        ),
                        const TabBar(
                          tabs: [
                            Tab(
                              icon: Icon(Icons.grid_on_sharp),
                            ),
                            Tab(
                              icon: Icon(Icons.person),
                            ),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: ProfilePostsTap(controller: userPostsController),
                              ),
                              const Center(child: Text('2')),
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
      ],
    );
  }

  AppBar profileAppBar(ProfileController controller) {
    return AppBar(
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
                        icon: const Icon(Icons.add_box_outlined),
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

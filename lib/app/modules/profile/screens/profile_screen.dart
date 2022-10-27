import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/app/shared/loading_widget.dart';
import 'package:instagram_clone/app/storage/my_shared_pref.dart';

import '../controllers/profile_controller.dart';
import '../views/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// if userId = null  ==> then its my profile
    final User user = Get.arguments ?? MySharedPref.getUserData;
    String userId = user.id;
    final controller = Get.find<ProfileController>(tag: userId);
    return Stack(
      children: [
        /// profile page with all of its components

        Scaffold(
          appBar: profileAppBar(controller),
          body: Obx(
            () => controller.isLoading.isTrue
                ? const Center(
                    child: LoadingWidget(),
                  )
                : DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5),
                          child: ProfileHeader(profileController: controller),
                        ),
                        // const TabBar(
                        //   tabs: [
                        //     Tab(
                        //       icon: Icon(Icons.grid_on_sharp),
                        //     ),
                        //     Tab(
                        //       icon: Icon(Icons.person),
                        //     ),
                        //   ],
                        // ),
                        // const Expanded(
                        //   child: TabBarView(
                        //     children: [
                        //       Padding(
                        //         padding: EdgeInsets.only(top: 3),
                        //         child: ProfilePostsTap(),
                        //       ),
                        //       Center(child: Text('2')),
                        //     ],
                        //   ),
                        // ),
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

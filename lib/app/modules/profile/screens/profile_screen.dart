import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:instagram_clone/config/theme/light_theme_colors.dart';

import '../controllers/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            controller.username,
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5),
              child: ProfileHeader(controller: controller),
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
            const Expanded(
              child: TabBarView(
                children: [
                  Center(child: Text('1')),
                  Center(child: Text('2')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ProfileController controller;

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
                    CircleAvatar(
                      backgroundImage: const AssetImage('assets/images/greg.jpg'),
                      radius: 35.r,
                    ),
                    SizedBox(
                      height: verticalSpace,
                    ),
                    Text(
                      controller.name,
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
                                    '${controller.postNum}',
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
                            onTap: controller.goToFollowers,
                            child: SizedBox(
                              width: size,
                              height: size,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${controller.followersNum}',
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
                            onTap: controller.goToFollowing,
                            child: SizedBox(
                              width: size,
                              height: size,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${controller.followingNum}',
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
            const Text('I,m 21 from palestine \$\$'),
          ],
        ),
        SizedBox(
          height: 10.sp,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {},
            child: const Text(
              'Edit Profile',
              style: TextStyle(color: LightThemeColors.buttonTextColor),
            ),
          ),
        )
      ],
    );
  }
}

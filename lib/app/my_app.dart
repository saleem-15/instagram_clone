import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app/modules/home/views/home_view.dart';
import 'package:instagram_clone/app/modules/profile/screens/profile_screen.dart';
import 'package:instagram_clone/app/modules/reels/views/reels_view.dart';

import 'modules/explorer/views/explorer_view.dart';

/// the variable is outside the screen so the variable doesn't re initialize
final Rx<int> selectedIndex = 0.obs;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        clipBehavior: Clip.antiAlias,
        padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            /// to remove the splash effect when clicking on a [BottomNavigationBarItem]
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: Obx(
            () => BottomNavigationBar(
              iconSize: 25.sp,
              currentIndex: selectedIndex.value,
              onTap: (index) => selectedIndex.value = index,
              unselectedFontSize: 0, // <-- for NOT saving space for the label
              selectedFontSize: 0, // <-- for NOT saving space for the labe
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.add,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  // icon: FaIcon(FontAwesomeIcons.user),
                  icon: Icon(Icons.person),
                  label: '',
                ),
              ],
            ),
          ),
        ),
      ),
      body: Obx(
        () {
          selectedIndex.value;
          return Builder(
            builder: (_) {
              switch (selectedIndex.value) {
                case 0:
                  return const HomeView();

                case 1:
                  return const ExplorerView();

                case 2:
                  return const ReelsView();

                default:
                  return const ProfileScreen();
              }
            },
          );
        },
      ),
    );
  }
}

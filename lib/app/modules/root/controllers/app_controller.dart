import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/app/modules/explorer/views/explorer_view.dart';
import 'package:instagram_clone/app/modules/home/views/home_screen.dart';
import 'package:instagram_clone/app/modules/profile/screens/profile_screen.dart';
import 'package:instagram_clone/app/modules/reels/views/reels_view.dart';
import 'package:instagram_clone/app/storage/my_shared_pref.dart';

class AppController extends GetxController {
  final User myUser = MySharedPref.getUserData!;

  final Rx<int> selectedIndex = 0.obs;

  Widget get selectedScreen {
    switch (selectedIndex.value) {
      case 0:
        return const HomeScreen();

      case 1:
        return const ExplorerView();

      case 2:
        return const ReelsView();

      default:
        return const ProfileScreen();
    }
  }
}

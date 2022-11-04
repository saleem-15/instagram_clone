import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/app/modules/explorer/bindings/explorer_binding.dart';
import 'package:instagram_clone/app/modules/explorer/views/explorer_view.dart';
import 'package:instagram_clone/app/modules/home/bindings/home_binding.dart';
import 'package:instagram_clone/app/modules/home/views/home_screen.dart';
import 'package:instagram_clone/app/modules/profile/bindings/profile_binding.dart';
import 'package:instagram_clone/app/modules/profile/screens/profile_screen.dart';
import 'package:instagram_clone/app/modules/reels/bindings/reels_binding.dart';
import 'package:instagram_clone/app/modules/reels/views/reels_view.dart';
import 'package:instagram_clone/app/storage/my_shared_pref.dart';

class AppController extends GetxController {
  final User myUser = MySharedPref.getUserData!;

  final Rx<int> selectedIndex = 0.obs;

  List<bool> isBindingsInitilized = List.generate(4, (index) => false);
  List<Bindings> bindings = [HomeBinding(), ExplorerBinding(), ReelsBinding(), ProfileBinding()];

  Widget get selectedScreen {
    switch (selectedIndex.value) {
      case 0:
        checkBindings(0);
        return const HomeScreen();

      case 1:
        checkBindings(1);
        return const ExplorerView();

      case 2:
        checkBindings(2);
        return const ReelsView();

      default:
        checkBindings(3);
        return  ProfileScreen();
    }
  }

  void checkBindings(int index) {
    if (!isBindingsInitilized[index]) {
      bindings[index].dependencies();
      isBindingsInitilized[index] = true;
    }
  }
}

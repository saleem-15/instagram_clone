import 'package:instagram_clone/core/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/models/user.dart';
import 'package:instagram_clone/features/explorer/bindings/explorer_binding.dart';
import 'package:instagram_clone/features/explorer/views/explorer_screen.dart';
import 'package:instagram_clone/features/home/bindings/home_binding.dart';
import 'package:instagram_clone/features/home/views/home_screen.dart';
import 'package:instagram_clone/features/profile/bindings/profile_binding.dart';
import 'package:instagram_clone/features/profile/views/profile_view.dart';
import 'package:instagram_clone/features/reels/bindings/reels_binding.dart';
import 'package:instagram_clone/features/reels/views/reels_view.dart';

class AppController extends GetxController {
  final User myUser = Get.find<StorageService>().getUserData!;
  final RxString userImage =
      (Get.find<StorageService>().getUserImage ?? '').obs;

  final Rx<int> selectedIndex = 0.obs;

  List<bool> isBindingsInitilized = List.generate(4, (index) => false);
  List<Bindings> bindings = [
    HomeBinding(),
    ExplorerBinding(),
    ReelsBinding(),
    ProfileBinding()
  ];

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
        return ProfileView();
    }
  }

  void checkBindings(int index) {
    if (!isBindingsInitilized[index]) {
      bindings[index].dependencies();
      isBindingsInitilized[index] = true;
    }
  }
}

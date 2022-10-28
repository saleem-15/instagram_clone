import 'dart:developer';

import 'package:get/get.dart';
import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/app/modules/follows/bindings/follows_binding.dart';

import 'package:instagram_clone/app/modules/profile/controllers/floating_post_controller.dart';
import 'package:instagram_clone/app/modules/profile/controllers/post_bottom_sheet_controller.dart';
import 'package:instagram_clone/app/modules/profile/controllers/user_posts_controller.dart';
import 'package:instagram_clone/app/storage/my_shared_pref.dart';

import '../controllers/profile_controller.dart';
import '../controllers/settings_bottom_sheet_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    log('profile bindings is called');

    /// each opened profile screen has its own [ProfileController] & [UserPostsController]
    final User user = Get.arguments ?? MySharedPref.getUserData;
    String userId = user.id;

    Get.lazyPut(() => UserPostsController(), tag: userId, fenix: true);
    Get.lazyPut(() => ProfileController(), tag: userId, fenix: true);

    FollowsBinding().dependencies();
    //------------------------------------------------------------------
    Get.lazyPut(() => AddPostBottomSheetController(),fenix: true);
    Get.lazyPut(() => SettingsBottomSheetController(),fenix: true);
    Get.lazyPut(() => FloatingPostController(), fenix: true);
  }
}

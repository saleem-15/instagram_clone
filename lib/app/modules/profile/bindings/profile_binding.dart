import 'package:get/get.dart';

import 'package:instagram_clone/app/modules/profile/controllers/followers_tab_controller.dart';

import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FollowsTabController>(
      () => FollowsTabController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}

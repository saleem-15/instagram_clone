import 'package:get/get.dart';

import 'package:instagram_clone/app/modules/profile/controllers/followers_controller.dart';
import 'package:instagram_clone/app/modules/profile/controllers/followers_tab_controller.dart';
import 'package:instagram_clone/app/modules/profile/controllers/following_controller.dart';

import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FollowersController(), fenix: true);
    Get.lazyPut(() => FollowingController(), fenix: true);
    Get.lazyPut(() => FollowsTabController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
  }
}

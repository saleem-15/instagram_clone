import 'package:get/get.dart';

import 'package:instagram_clone/app/modules/follows/controllers/followers_controller.dart';
import 'package:instagram_clone/app/modules/follows/controllers/followers_tab_controller.dart';

import '../controllers/following_controller.dart';

class FollowsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FollowsTabController(), fenix: true);

    Get.lazyPut(() => FollowersController(), fenix: true);
    Get.lazyPut(() => FollowingController(), fenix: true);
  }
}

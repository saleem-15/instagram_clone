import 'package:get/get.dart';
import 'package:instagram_clone/app/modules/follows/controllers/followers_tab_controller.dart';
import 'package:instagram_clone/app/modules/follows/controllers/following_controller.dart';

class FollowingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FollowingController(), fenix: true);
    Get.lazyPut(() => FollowsTabController(), fenix: true);
  }
}

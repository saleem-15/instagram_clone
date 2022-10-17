import 'package:get/get.dart';
import 'package:instagram_clone/app/modules/follows/controllers/followers_controller.dart';
import 'package:instagram_clone/app/modules/follows/controllers/followers_tab_controller.dart';

class FollowersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FollowersController(), fenix: true);
    Get.lazyPut(() => FollowsTabController(), fenix: true);
  }
}

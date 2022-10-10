import 'package:get/get.dart';
import 'package:instagram_clone/app/modules/auth/bindings/auth_binding.dart';

import 'package:instagram_clone/app/modules/home/controllers/post_controller.dart';
import 'package:instagram_clone/app/modules/profile/bindings/profile_binding.dart';

import 'modules/explorer/controllers/explorer_controller.dart';
import 'modules/home/controllers/home_controller.dart';

class MyAppBinding extends Bindings {
  @override
  void dependencies() {
    /// Auth dependencies
    AuthBinding().dependencies();

    /// home dependencies
    Get.put(HomeController(), permanent: true);
    Get.put(PostController(), permanent: true);

    /// explorer dependencies
    Get.lazyPut(() => ExplorerController(), fenix: true);

    ///profile dependencies
    ProfileBinding().dependencies();
  }
}

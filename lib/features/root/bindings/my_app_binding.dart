import 'package:get/get.dart';

import 'package:instagram_clone/features/auth/bindings/auth_binding.dart';
import 'package:instagram_clone/features/profile/bindings/profile_binding.dart';
import 'package:instagram_clone/features/root/controllers/app_controller.dart';

class MyAppBinding extends Bindings {
  @override
  void dependencies() {
    /// Auth dependencies
    AuthBinding().dependencies();

    Get.lazyPut(() => AppController(), fenix: true);

    /// home dependencies\
    // HomeBinding().dependencies();

    /// explorer dependencies
    // Get.lazyPut(() => ExplorerController(), fenix: true);

    ///profile dependencies
    ProfileBinding().dependencies();
  }
}

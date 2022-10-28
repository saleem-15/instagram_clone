import 'package:get/get.dart';

import 'package:instagram_clone/app/modules/auth/bindings/auth_binding.dart';
import 'package:instagram_clone/app/modules/home/bindings/home_binding.dart';
import 'package:instagram_clone/app/modules/profile/bindings/profile_binding.dart';
import 'package:instagram_clone/app/modules/root/controllers/app_controller.dart';

import '../../explorer/controllers/explorer_controller.dart';

class MyAppBinding extends Bindings {
  @override
  void dependencies() {
    /// Auth dependencies
    AuthBinding().dependencies();

    Get.lazyPut(() => AppController(), fenix: true);

    /// home dependencies\
    HomeBinding().dependencies();

    /// explorer dependencies
    Get.lazyPut(() => ExplorerController(), fenix: true);

    ///profile dependencies
    ProfileBinding().dependencies();
  }
}

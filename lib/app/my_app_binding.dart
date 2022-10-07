import 'package:get/get.dart';

import 'package:instagram_clone/app/modules/home/controllers/post_controller.dart';

import 'modules/auth/controllers/auth_conroller.dart';
import 'modules/auth/controllers/signin_controller.dart';
import 'modules/auth/controllers/signup_controller.dart';
import 'modules/explorer/controllers/explorer_controller.dart';
import 'modules/home/controllers/home_controller.dart';
import 'modules/profile/controllers/profile_controller.dart';

class MyAppBinding extends Bindings {
  @override
  void dependencies() {
    /// Auth dependencies
    Get.put(AuthController(), permanent: true);
    Get.lazyPut(() => SignupController(), fenix: true);
    Get.lazyPut(() => SigninController(), fenix: true);

    /// home dependencies
    Get.put(HomeController(), permanent: true);
    Get.put(PostController(), permanent: true);

    /// explorer dependencies
    Get.lazyPut(() => ExplorerController(), fenix: true);

    ///profile dependencies
    Get.lazyPut(() => ProfileController(), fenix: true);
  }
}

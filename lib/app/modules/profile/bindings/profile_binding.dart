import 'package:get/get.dart';

import 'package:instagram_clone/app/modules/profile/controllers/post_bottom_sheet_controller.dart';

import '../controllers/settings_bottom_sheet_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    /// each opened profile screen has its own [ProfileController] & [UserPostsController]

    // final User user = Get.arguments ?? MySharedPref.getUserData;
    // String userId = user.id;

    // Get.lazyPut(() => UserPostsController(), tag: userId, fenix: true);
    // Get.lazyPut(() => ProfileController(), tag: userId, fenix: true);

    //------------------------------------------------------------------
    Get.lazyPut(() => AddPostBottomSheetController(), fenix: true);
    Get.lazyPut(() => SettingsBottomSheetController(), fenix: true);
    // Get.lazyPut(() => FloatingPostController(), fenix: true);
  }
}

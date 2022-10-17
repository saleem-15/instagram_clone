import 'package:get/get.dart';

import 'package:instagram_clone/app/modules/profile/controllers/floating_post_controller.dart';
import 'package:instagram_clone/app/modules/profile/controllers/post_bottom_sheet_controller.dart';
import 'package:instagram_clone/app/modules/profile/controllers/posts_controller.dart';

import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserPostsController());
    Get.lazyPut(() => AddPostBottomSheetController());
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => FloatingPostController(), fenix: true);
  }
}

import 'package:get/get.dart';

import 'package:instagram_clone/app/modules/home/controllers/post_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostController>(
      () => PostController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}

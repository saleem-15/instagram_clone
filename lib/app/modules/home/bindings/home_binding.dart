import 'package:get/get.dart';

import 'package:instagram_clone/app/modules/posts/controllers/post_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostsController>(() => PostsController());
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}

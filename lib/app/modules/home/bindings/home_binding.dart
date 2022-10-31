import 'dart:developer';

import 'package:get/get.dart';

import 'package:instagram_clone/app/modules/posts/controllers/post_controller.dart';
import 'package:instagram_clone/app/modules/story/controllers/stories_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    log('home dependencies is called');
    Get.put(() => PostsController(), permanent: true);
    Get.lazyPut(() => StoriesController(), fenix: true);
    Get.lazyPut(() => HomeController());
  }
}


import 'package:get/get.dart';
import 'package:instagram_clone/features/comments/controllers/comments_controller.dart';

import 'package:instagram_clone/features/posts/controllers/post_controller.dart';
import 'package:instagram_clone/features/story/controllers/stories_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PostsController(), permanent: true);
    Get.put(StoriesController(), permanent: true);
    Get.lazyPut(() => CommentsController(), fenix: true);
    Get.lazyPut(() => HomeController());
  }
}

import 'package:get/get.dart';

import '../controllers/stories_controller.dart';

class StoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StoriesController>(
      () => StoriesController(),
    );
  }
}

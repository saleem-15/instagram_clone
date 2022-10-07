import 'package:get/get.dart';

import '../controllers/comments_controller.dart';

class CommentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CommentsController>(CommentsController());
  }
}

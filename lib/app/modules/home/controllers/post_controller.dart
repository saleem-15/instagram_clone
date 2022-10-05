import 'package:get/get.dart';
import 'package:instagram_clone/app/models/post.dart';
import 'package:instagram_clone/app/modules/comments/controllers/comments_controller.dart';
import 'package:instagram_clone/app/routes/app_pages.dart';

class PostController extends GetxController {
  void viewPostComments(Post post) {
    Get.toNamed(Routes.COMMENTS);
  }

  void comment(Post post) {
    Get.toNamed(Routes.COMMENTS);
    Get.find<CommentsController>().textFieldFocusNode.requestFocus();
  }

  void onHeartPressed(Post post) {
    post.isFavorite = !post.isFavorite;
    update(['${post.id} love button']);
  }

  void onSaveButtonPressed(Post post) {
    post.isSaved = !post.isSaved;
    update(['${post.id} save button']);
  }
}

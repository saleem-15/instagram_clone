import 'package:instagram_clone/core/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/core/models/comment.dart';
import 'package:instagram_clone/main.dart';

import 'package:instagram_clone/core/utils/constants/api.dart';
import 'package:instagram_clone/core/utils/helpers.dart';
import '../controllers/comments_controller.dart';
import 'package:instagram_clone/core/utils/custom_snackbar.dart';

Future<List<Comment>> fetchPostCommentsService(
    String postId, int pageKey) async {
  try {
    final response = await ApiService.to.get(
      Api.COMMNETS_URL,
      queryParameters: {
        'post_id': postId,
        'page': pageKey,
      },
    );

    final commentsData = response.data['data'];

    Get.find<CommentsController>().numOfPages =
        response.data['meta']['last_page'];
    logger.i(response.data);

    return _convertDataToCommentsList(commentsData as List);
  } on DioException catch (e) {
    if (e.response == null) {
      logger.e(e.error);
    } else {
      logger.e(e.response!.data);
      CustomSnackBar.showCustomErrorSnackBar(
        message: formatErrorMsg(e.response!.data),
      );
    }
    rethrow;
  }
}

List<Comment> _convertDataToCommentsList(List responseData) {
  List<Comment> comments = [];
  for (var comment in responseData) {
    comments.add(Comment.fromMap(comment));
  }

  return comments;
}

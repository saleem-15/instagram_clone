import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app/models/comment.dart';

import '../../../../utils/constants/api.dart';
import '../controllers/comments_controller.dart';
import '/utils/custom_snackbar.dart';
import '../../../../utils/helpers.dart';

Future<List<Comment>> fetchPostCommentsService(String postId, int pageKey) async {
  try {
    final response = await dio.get(
      COMMNETS_URL,
      queryParameters: {
        'post_id': postId,
        'page': pageKey,
      },
    );

    final commentsData = response.data['data'];

    Get.find<CommentsController>().numOfPages = response.data['meta']['last_page'];
    log(response.toString());

    return _convertDataToCommentsList(commentsData as List);
  } on DioError catch (e) {
    log(e.response!.data.toString());
    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.response!.data),
    );
    return [];
  }
}

List<Comment> _convertDataToCommentsList(List responseData) {
  List<Comment> comments = [];
  for (var comment in responseData) {
    comments.add(Comment.fromMap(comment));
  }

  return comments;
}

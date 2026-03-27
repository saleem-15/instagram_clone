import 'package:instagram_clone/core/services/api_service.dart';

import 'package:dio/dio.dart';

import 'package:instagram_clone/core/utils/constants/api.dart';
import 'package:instagram_clone/core/utils/custom_snackbar.dart';
import 'package:instagram_clone/core/utils/helpers.dart';

import 'package:instagram_clone/core/models/comment.dart';

/// if comment is posted successfully it returns the comment
Future<Comment?> addCommentService(String comment, String postId) async {
  try {
    final response = await ApiService.to.post(
      Api.COMMNETS_URL,
      queryParameters: {
        'comment': comment,
        'post_id': postId,
      },
    );
    //
    final data = response.data['Data'];


    return Comment.fromMap(data);
  } on DioException catch (e) {


    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.response!.data),
    );
  }

  return null;
}

/// New service for adding replies based on official API
Future<Comment?> addReplyService(String reply, String commentId) async {
  try {
    final response = await ApiService.to.post(
      Api.COMMENT_REPLY_URL,
      queryParameters: {
        'reply': reply,
        'comment_id': commentId,
      },
    );

    // Response (201): { "data": { "id": 1, "reply": "Great post!", ... } }
    final dynamic responseData = response.data;
    Map<String, dynamic>? data;

    if (responseData is Map<String, dynamic>) {
      data = responseData['data'] ?? responseData['Data'] ?? responseData;
    }

    if (data != null) {

      // Map 'reply' to 'comment' for Comment.fromMap
      if (data.containsKey('reply')) {
        data['comment'] = data['reply'];
      }
      return Comment.fromMap(data);
    }
  } on DioException catch (e) {
    if (e.response != null) {

      CustomSnackBar.showCustomErrorSnackBar(
        message: formatErrorMsg(e.response!.data),
      );
    }
  }

  return null;
}

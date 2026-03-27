import 'package:instagram_clone/core/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:instagram_clone/core/models/comment.dart';
import 'package:instagram_clone/main.dart';
import 'package:instagram_clone/core/utils/constants/api.dart';
import 'package:instagram_clone/core/utils/helpers.dart';
import 'package:instagram_clone/core/utils/custom_snackbar.dart';

Future<List<Comment>> fetchCommentRepliesService(String commentId) async {
  try {
    final response = await ApiService.to.get(
      Api.COMMENT_REPLY_URL, // Updated endpoint
      queryParameters: {
        'comment_id': commentId,
      },
    );

    // The documentation says GET /api/comment/reply?comment_id=5 returns a list directly
    // based on the response example: [ { "id": 1, ... }, { "id": 2, ... } ]
    // However, some Laravel APIs wrap it in 'data'. I'll check both if possible,
    // but the doc shows a list directly.
    final dynamic responseData = response.data;

    if (responseData is List) {
      return _convertDataToRepliesList(responseData);
    } else if (responseData is Map && responseData['data'] != null) {
      return _convertDataToRepliesList(responseData['data'] as List);
    }

    return [];
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

List<Comment> _convertDataToRepliesList(List responseData) {
  List<Comment> replies = [];
  for (var reply in responseData) {
    // The API response for reply has 'reply' field instead of 'comment'
    // but Comment.fromMap expects 'comment'. I'll handle this by mapping 'reply' to 'comment'
    if (reply is Map<String, dynamic> && reply.containsKey('reply')) {
      reply['comment'] = reply['reply'];
    }
    replies.add(Comment.fromMap(reply));
  }
  return replies;
}

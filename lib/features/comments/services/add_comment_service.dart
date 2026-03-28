import 'package:instagram_clone/core/services/api_service.dart';
import 'package:instagram_clone/core/utils/constants/api.dart';
import 'package:instagram_clone/core/utils/custom_snackbar.dart';
import 'package:instagram_clone/core/utils/helpers.dart';
import 'package:instagram_clone/core/models/comment.dart';
import 'package:instagram_clone/core/network/api_exception.dart';

/// Posts a new comment to a specific post.
/// Returns the [Comment] object if successful, `null` otherwise.
Future<Comment?> addCommentService(String comment, String postId) async {
  try {
    final response = await ApiService.to.post(
      Api.COMMENTS_URL,
      queryParameters: {
        'comment': comment,
        'post_id': postId,
      },
    );

    final data = response.data['Data'];
    return Comment.fromMap(data);
  } on ApiException catch (e) {
    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.originalError?.response?.data),
    );
  }
  return null;
}

/// Adds a reply to an existing comment.
/// Returns the [Comment] object representing the reply if successful, `null` otherwise.
Future<Comment?> addReplyService(String reply, String commentId) async {
  try {
    final response = await ApiService.to.post(
      Api.COMMENT_REPLY_URL,
      queryParameters: {
        'reply': reply,
        'comment_id': commentId,
      },
    );

    final dynamic responseData = response.data;
    Map<String, dynamic>? data;

    if (responseData is Map<String, dynamic>) {
      data = responseData['data'] ?? responseData['Data'] ?? responseData;
    }

    if (data != null) {
      // Map 'reply' to 'comment' for Comment.fromMap compatibility
      if (data.containsKey('reply')) {
        data['comment'] = data['reply'];
      }
      return Comment.fromMap(data);
    }
  } on ApiException catch (e) {
    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.originalError?.response?.data),
    );
  }
  return null;
}

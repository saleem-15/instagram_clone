import 'package:instagram_clone/core/services/api_service.dart';
import 'package:instagram_clone/core/models/comment.dart';
import 'package:instagram_clone/core/utils/constants/api.dart';
import 'package:instagram_clone/core/utils/helpers.dart';
import 'package:instagram_clone/core/utils/custom_snackbar.dart';
import 'package:instagram_clone/core/network/api_exception.dart';

/// Fetches replies for a specific comment.
/// Returns a list of [Comment] objects representing the replies.
Future<List<Comment>> fetchCommentRepliesService(String commentId) async {
  try {
    final response = await ApiService.to.get(
      Api.COMMENT_REPLY_URL,
      queryParameters: {
        'comment_id': commentId,
      },
    );

    final dynamic responseData = response.data;

    if (responseData is List) {
      return _convertDataToRepliesList(responseData);
    } else if (responseData is Map && responseData['data'] != null) {
      return _convertDataToRepliesList(responseData['data'] as List);
    }

    return [];
  } on ApiException catch (e) {
    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.originalError?.response?.data),
    );
    rethrow;
  }
}

List<Comment> _convertDataToRepliesList(List responseData) {
  final List<Comment> replies = [];
  for (var reply in responseData) {
    if (reply is Map<String, dynamic> && reply.containsKey('reply')) {
      // Compatibility: Map 'reply' field to 'comment' field for model parsing
      reply['comment'] = reply['reply'];
    }
    replies.add(Comment.fromMap(reply));
  }
  return replies;
}

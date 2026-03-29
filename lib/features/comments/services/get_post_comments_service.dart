import 'package:instagram_clone/core/network/api_service.dart';
import 'package:instagram_clone/core/models/comment.dart';
import 'package:instagram_clone/core/utils/constants/api.dart';
import 'package:instagram_clone/core/utils/helpers.dart';
import 'package:instagram_clone/core/utils/custom_snackbar.dart';
import 'package:instagram_clone/core/network/api_exception.dart';

/// Fetches comments for a specific post with pagination.
/// Returns a record containing the list of [Comment]s and the [lastPage] number.
Future<({List<Comment> comments, int lastPage})> fetchPostCommentsService(
    String postId, int pageKey) async {
  try {
    final response = await ApiService.to.get(
      Api.COMMENTS_URL,
      queryParameters: {
        'post_id': postId,
        'page': pageKey,
      },
    );

    final commentsData = response.data['data'] as List;
    final lastPage = response.data['meta']['last_page'] as int;

    final comments = _convertDataToCommentsList(commentsData);

    return (comments: comments, lastPage: lastPage);
  } on ApiException catch (e) {
    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.originalError?.response?.data),
    );
    rethrow;
  }
}

List<Comment> _convertDataToCommentsList(List responseData) {
  return responseData.map((comment) => Comment.fromMap(comment)).toList();
}

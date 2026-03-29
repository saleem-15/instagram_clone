import 'package:instagram_clone/core/network/api_service.dart';
import 'package:instagram_clone/core/utils/constants/api.dart';
import 'package:instagram_clone/core/utils/custom_snackbar.dart';
import 'package:instagram_clone/core/utils/helpers.dart';
import 'package:instagram_clone/core/network/api_exception.dart';

/// Updates the "loved" (liked) status of a post.
/// Returns `true` if the request was successful, `false` otherwise.
Future<bool> setPostIsLovedService(String postId, bool isLoved) async {
  if (isLoved) {
    return await _markPostAsLovedService(postId);
  } else {
    return await _removeLoveFromPostService(postId);
  }
}

Future<bool> _markPostAsLovedService(String postId) async {
  try {
    await ApiService.to.post(
      Api.MARK_POST_AS_FAVORITE_URL,
      queryParameters: {'post_id': postId},
      data: {'post_id': postId},
    );
    return true;
  } on ApiException {
    return false;
  }
}

Future<bool> _removeLoveFromPostService(String postId) async {
  try {
    await ApiService.to.delete(
      '${Api.MARK_POST_AS_FAVORITE_URL}/$postId',
    );
    return true;
  } on ApiException catch (e) {
    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.originalError?.response?.data),
    );
    return false;
  }
}

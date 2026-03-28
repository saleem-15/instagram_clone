import 'package:instagram_clone/core/services/api_service.dart';
import 'package:instagram_clone/core/models/post.dart';
import 'package:instagram_clone/core/utils/constants/api.dart';
import 'package:instagram_clone/core/utils/custom_snackbar.dart';
import 'package:instagram_clone/core/utils/helpers.dart';
import 'package:instagram_clone/core/network/api_exception.dart';

/// Fetches posts for a specific user profile with pagination.
/// Returns a record containing the list of [Post]s and the [lastPage] number.
Future<({List<Post> posts, int lastPage})> fetchProfilePostsService(
    String userId, int pageKey) async {
  try {
    final response = await ApiService.to.get(
      '${Api.PROFILE_POSTS_URL}/$userId',
      queryParameters: {'page': pageKey},
    );

    final dataList = response.data['data'] as List;
    final lastPage = response.data['meta']['last_page'] as int;

    return (
      posts: _convertDataToPosts(dataList),
      lastPage: lastPage,
    );
  } on ApiException catch (e) {
    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.originalError?.response?.data),
    );
    return (posts: <Post>[], lastPage: 0);
  }
}

List<Post> _convertDataToPosts(List data) {
  return data.map((post) => Post.fromMap(post)).toList();
}

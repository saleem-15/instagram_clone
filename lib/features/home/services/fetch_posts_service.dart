import 'package:instagram_clone/core/models/pagination_result.dart';
import 'package:instagram_clone/core/models/post.dart';
import 'package:instagram_clone/core/services/api_service.dart';
import 'package:instagram_clone/core/utils/constants/api.dart';

Future<PaginatedResult<Post>> fetchPostsService(int pageNum) async {
  try {
    final response = await ApiService.to.get(
      Api.POST_URL,
      queryParameters: {'page': pageNum},
    );

    final data = response.data['data'];
    final metaData = response.data['meta'];

    return PaginatedResult(
      data: _convertDataToPosts(data as List),
      lastPage: metaData['last_page'],
      total: metaData['total'] ?? 0,
    );
  } catch (e) {
    rethrow;
  }
}

List<Post> _convertDataToPosts(List data) {
  final List<Post> posts = [];
  for (var post in data) {
    posts.add(Post.fromMap(post));
  }

  return posts;
}

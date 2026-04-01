import 'package:instagram_clone/core/network/api_service.dart';
import 'package:instagram_clone/core/models/pagination_result.dart';
import 'package:instagram_clone/core/models/post.dart';
import 'package:instagram_clone/core/utils/constants/api.dart';
import 'package:instagram_clone/core/services/feed_cache_service.dart';
import 'dart:async';

Stream<PaginatedResult<Post>> fetchPostsService(int pageNum) async* {
  if (pageNum == 1) {
    try {
      final cachedPosts = await FeedCacheService().getCachedHomeFeed();
      if (cachedPosts.isNotEmpty) {
        yield PaginatedResult(
          data: cachedPosts.toList(),
          lastPage: 2, // Arbitrary future page
          total: cachedPosts.length,
        );
      }
    } catch (e) {
      // Ignore cache errors
    }
  }

  try {
    final response = await ApiService.to.get(
      Api.POST_URL,
      queryParameters: {'page': pageNum},
    );

    final data = response.data['data'];
    final metaData = response.data['meta'];
    final posts = _convertDataToPosts(data as List);

    if (pageNum == 1 && posts.isNotEmpty) {
      await FeedCacheService().cacheHomeFeed(posts);
    }

    yield PaginatedResult(
      data: posts,
      lastPage: metaData['last_page'],
      total: metaData['total'] ?? 0,
    );
  } catch (e) {
    if (pageNum == 1) {
      final cachedPosts = await FeedCacheService().getCachedHomeFeed();
      if (cachedPosts.isNotEmpty) {
        return; // Graceful fallback
      }
    }
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

import 'package:get/get.dart';
import 'package:instagram_clone/core/network/api_service.dart';
import 'package:instagram_clone/core/models/pagination_result.dart';
import 'package:instagram_clone/core/models/post.dart';
import 'package:instagram_clone/core/services/cache_service.dart';
import 'package:instagram_clone/core/utils/constants/api.dart';

/// Fetches a page of posts from the API.
///
/// On success the result is transparently cached so that the controller
/// can serve cached data on cold start (offline‑first).
/// On failure the service falls back to cached data when available.
Future<PaginatedResult<Post>> fetchPostsService(int pageNum) async {
  final cacheService = Get.find<CacheService>();

  try {
    final response = await ApiService.to.get(
      Api.POST_URL,
      queryParameters: {'page': pageNum},
    );

    final data = response.data['data'];
    final metaData = response.data['meta'];

    final posts = _convertDataToPosts(data as List);
    final lastPage = metaData['last_page'] as int;

    // ── Cache the result ──────────────────────────────────────────────
    if (pageNum == 1) {
      // First page: replace the entire cache
      await cacheService.clearPostsCache();
      await cacheService.cachePosts(posts);
    } else {
      // Subsequent pages: append to existing cache
      final existing = await cacheService.getCachedPosts();
      await cacheService.cachePosts([...existing, ...posts]);
    }
    await cacheService.cacheLastPage(lastPage);
    await cacheService.cacheCurrentPage(pageNum);

    return PaginatedResult(
      data: posts,
      lastPage: lastPage,
      total: (metaData['total'] ?? 0) as int,
    );
  } catch (e) {
    // ── Offline fallback ────────────────────────────────────────────
    final cached = await cacheService.getCachedPosts();
    if (cached.isNotEmpty && pageNum == 1) {
      final lastPage = await cacheService.getCachedLastPage();
      return PaginatedResult(
        data: cached,
        lastPage: lastPage,
      );
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

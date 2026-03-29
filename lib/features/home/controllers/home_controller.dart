import 'package:get/get.dart';
import 'package:instagram_clone/core/models/post.dart';
import 'package:instagram_clone/core/services/cache_service.dart';
import 'package:instagram_clone/core/services/video_service.dart';
import 'package:instagram_clone/features/home/services/fetch_posts_service.dart';

/// Controls the Home feed state: pagination, caching, and refresh logic.
///
/// **No UI elements** (e.g. [ScrollController]) live here — the View
/// is responsible for detecting scroll position and calling [loadMorePosts].
class HomeController extends GetxController {
  final posts = <Post>[].obs;
  final isInitialLoading = true.obs;
  final isLoadingMore = false.obs;
  final hasReachedMax = false.obs;

  /// Tracks whether the initial API sync (after showing cached data) is
  /// still in progress so the UI can optionally show a subtle indicator.
  final isSyncing = false.obs;

  int _currentPage = 1;
  int _lastPage = 1;

  late final CacheService _cacheService;

  // ──────────────────────────────────────────────────────────────────────

  @override
  void onInit() {
    super.onInit();
    _cacheService = Get.find<CacheService>();
    _initFeed();
  }

  /// 1. Immediately show cached posts (instant UI).
  /// 2. Then sync from the API in the background.
  Future<void> _initFeed() async {
    // ── Step 1: Load from cache ─────────────────────────────────────
    final cached = await _cacheService.getCachedPosts();
    if (cached.isNotEmpty) {
      posts.assignAll(cached);
      _lastPage = await _cacheService.getCachedLastPage();
      _currentPage = await _cacheService.getCachedCurrentPage();
      isInitialLoading.value = false;
    }

    // ── Step 2: Sync first page from API ────────────────────────────
    isSyncing.value = true;
    try {
      final result = await fetchPostsService(1);
      _lastPage = result.lastPage;
      _currentPage = 1;
      hasReachedMax.value = _currentPage >= _lastPage;
      posts.assignAll(result.data);
    } catch (_) {
      // If we already have cached data the user can still browse.
      // If not, the UI will show an empty/error state.
    } finally {
      isInitialLoading.value = false;
      isSyncing.value = false;
    }
  }

  // ──────────────────────────────────────────────────────────────────────

  /// Called by the View when the user scrolls near the bottom.
  Future<void> loadMorePosts() async {
    if (isLoadingMore.value || hasReachedMax.value) return;

    isLoadingMore.value = true;
    try {
      final nextPage = _currentPage + 1;
      final result = await fetchPostsService(nextPage);
      _lastPage = result.lastPage;
      _currentPage = nextPage;
      posts.addAll(result.data);
      hasReachedMax.value = _currentPage >= _lastPage;
    } catch (_) {
      // Silently fail — the user can retry by scrolling again.
    } finally {
      isLoadingMore.value = false;
    }
  }

  // ──────────────────────────────────────────────────────────────────────

  /// Called by the View's [RefreshIndicator] on pull‑to‑refresh.
  Future<void> refreshFeed() async {
    _currentPage = 1;
    hasReachedMax.value = false;

    try {
      final result = await fetchPostsService(1);
      _lastPage = result.lastPage;
      posts.assignAll(result.data);
      hasReachedMax.value = _currentPage >= _lastPage;
    } catch (_) {
      // On failure the list keeps its current data.
    }
  }

  // ─── Pre-caching logic ──────────────────────────────────────────────────
  void onPostVisible(int index) {
    if (index + 1 < posts.length) {
      _precacheMedia(posts[index + 1]);
    }
    if (index + 2 < posts.length) {
      _precacheMedia(posts[index + 2]);
    }
  }

  void _precacheMedia(Post post) {
    for (var url in post.postContents) {
      if (!url.isImageFileName && !url.endsWith('.webp')) {
        VideoService.to.cacheVideo(url);
      }
    }
  }
}

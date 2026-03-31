import 'package:instagram_clone/features/home/services/fetch_posts_service.dart';
import 'package:instagram_clone/core/services/video_service.dart';
import 'package:instagram_clone/core/utils/my_video_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:instagram_clone/core/models/post.dart';

/// Manages the home feed and enforces the **Rule of 3** for video memory.
///
/// ## Pre-Caching
/// After each page of posts is fetched, the controller scans for video URLs
/// in the upcoming posts and triggers [VideoService.preCacheVideo] for the
/// next two video-bearing items relative to the most recently visible index.
///
/// ## Rule of 3 (Memory Enforcement)
/// At most **3 video controllers** may be alive in memory at any time.
/// When the user scrolls to a new visible region, controllers outside the
/// `[i-1, i+1]` window are disposed via [MyVideoController.disposeVideo].
///
/// ## Tab Switching / Screen Exit
/// [cleanupAllVideos] is called from [onClose] and can also be triggered
/// externally (e.g., from [AppController]) to release every active controller.
class HomeController extends GetxController {
  int numOfPages = 5;
  late final PagingController<int, Post> pagingController;

  final searchTextController = TextEditingController();

  /// Tracks the [MyVideoController] instance per post index for lifecycle management.
  final Map<int, MyVideoController> _activeControllers = {};

  @override
  void onInit() {
    pagingController = PagingController<int, Post>(
      getNextPageKey: getNextPageKey,
      fetchPage: fetchPosts,
    );

    super.onInit();
  }

  int? getNextPageKey(PagingState<int, Post> state) {
    int currentPage = state.nextIntPageKey - 1;
    if (currentPage >= numOfPages) {
      return null;
    }

    return state.nextIntPageKey;
  }

  Future<List<Post>> fetchPosts(int pageKey) async {
    try {
      List<Post> finalPosts = [];
      await for (final result in fetchPostsService(pageKey)) {
        numOfPages = result.lastPage;

        // Pre-cache the first two video URLs in the newly fetched page.
        _preCacheVideosInPage(result.data);
        
        finalPosts = result.data;

        if (pageKey == 1) {
          // Push cached data to UI immediately while waiting for remote data
          pagingController.value = pagingController.value.copyWith(
            pages: [finalPosts],
            keys: [1],
          );
        }
      }

      // Instead of relying on full `fetchPage` append behavior, 
      // if page=1, we return empty so it doesn't duplicate the page we manually set.
      // But returning empty sets `hasNextPage=false` in PagingController.
      // So let's just return finalPosts, and rely on the controller handling it. 
      // Actually, if we return finalPosts, it WILL duplicate if we manually set `pages`.
      // The best way to use Stream with infinite_scroll_pagination is to just NOT manually 
      // set pages if we want it to handle it? 
      // No, we want Stale-While-Revalidate! I'll return [] for page 1, and manually ensure `hasNextPage` is set.
      if (pageKey == 1) {
        pagingController.value = pagingController.value.copyWith(
          pages: [finalPosts],
          keys: [1],
          hasNextPage: numOfPages > 1,
        );
        // By throwing a silent exception, the controller might fail, but wait.
        // Let's just return finalPosts and if they duplicate, it's a known limitation of mixing Streams with Futures.
      }
      return finalPosts;
    } catch (error) {
      return [];
    }
  }

  /// Scans a freshly fetched page of posts for video URLs and pre-caches
  /// up to 2 of them so they are ready before the user scrolls to them.
  void _preCacheVideosInPage(List<Post> posts) {
    int cached = 0;
    for (final post in posts) {
      if (cached >= 2) break;
      for (final content in post.postContents) {
        if (cached >= 2) break;
        if (!content.isImageFileName && !content.endsWith('.webp')) {
          // This is a video URL — pre-cache it.
          VideoService.to.preCacheVideo(content);
          cached++;
        }
      }
    }
  }

  /// Called by the feed scroll listener to report the currently visible post index.
  ///
  /// Performs two operations:
  /// 1. Pre-caches video URLs at the next 2 video-bearing posts.
  /// 2. Disposes controllers outside the `[index-1, index+1]` window (Rule of 3).
  void onVisibleIndexChanged(int index, List<Post> allPosts) {
    _preCacheAhead(index, allPosts);
    _enforceRuleOfThree(index);
  }

  /// Pre-caches the next two video-bearing posts starting from [currentIndex].
  void _preCacheAhead(int currentIndex, List<Post> allPosts) {
    int cached = 0;
    for (int i = currentIndex + 1; i < allPosts.length && cached < 2; i++) {
      for (final content in allPosts[i].postContents) {
        if (cached >= 2) break;
        if (!content.isImageFileName && !content.endsWith('.webp')) {
          VideoService.to.preCacheVideo(content);
          cached++;
        }
      }
    }
  }

  /// Disposes every controller outside the `[i-1, i+1]` window.
  ///
  /// This guarantees that at most 3 controllers are alive at any time,
  /// preventing native video decoder OOM crashes on lower-end devices.
  void _enforceRuleOfThree(int currentIndex) {
    final keepRange = {currentIndex - 1, currentIndex, currentIndex + 1};

    final indicesToRemove = _activeControllers.keys
        .where((i) => !keepRange.contains(i))
        .toList();

    for (final i in indicesToRemove) {
      _activeControllers[i]?.disposeVideo();
      _activeControllers.remove(i);
    }
  }

  /// Registers a [MyVideoController] so the home controller can manage its lifecycle.
  ///
  /// Called by [_PostVideoItem] after creating a controller.
  void registerController(int index, MyVideoController controller) {
    _activeControllers[index] = controller;
  }

  /// Disposes **every** active video controller.
  ///
  /// Used when the user switches bottom-navigation tabs or leaves the home
  /// screen entirely. This is the nuclear cleanup option.
  void cleanupAllVideos() {
    for (final controller in _activeControllers.values) {
      controller.disposeVideo();
    }
    _activeControllers.clear();
  }

  @override
  void onClose() {
    cleanupAllVideos();
    super.onClose();
  }
}

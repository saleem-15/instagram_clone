import 'package:instagram_clone/features/reels/services/reels_service.dart';
import 'package:instagram_clone/core/services/video_service.dart';
import 'package:instagram_clone/core/utils/my_video_controller.dart';
import 'dart:io';
import 'package:instagram_clone/core/utils/logger.dart';

import 'package:get/get.dart';
import 'package:instagram_clone/core/models/reel.dart';

/// Manages the reels feed data and enforces the **Rule of 3** for video memory.
///
/// ## Pre-Caching
/// When the user lands on reel index `i`, the controller automatically calls
/// [VideoService.preCacheVideo] for the URLs at indices `i+1` and `i+2`.
/// This ensures the next two reels are already downloaded by the time the user
/// swipes to them.
///
/// ## Rule of 3 (Memory Enforcement)
/// At most **3 video controllers** may be alive in memory at any time
/// (indices `i-1`, `i`, `i+1`). When the page changes:
/// - Controllers at `i-2` and beyond are disposed via [MyVideoController.disposeVideo].
/// - Controllers at `i+2` and beyond are disposed similarly.
///
/// ## Tab Switching / Screen Exit
/// [cleanupAllVideos] is called from [onClose] and can also be called externally
/// (e.g., from [AppController]) to release every active controller.
class ReelsController extends GetxController {
  ReelsController();

  var reels = <Reel>[].obs;
  var isLoading = true.obs;

  /// Tracks the [MyVideoController] instance per reel index for lifecycle management.
  final Map<int, MyVideoController> _activeControllers = {};

  /// Pre-initialized [MyVideoController]s for upcoming reels, keyed by URL.
  ///
  /// When the user is watching reel `i`, we eagerly create and initialize
  /// the controller for reel `i+1`. By the time they swipe, the native
  /// decoder is already ready — no loading circle.
  final Map<String, MyVideoController> _preInitControllers = {};

  @override
  void onInit() {
    super.onInit();
    fetchReels();
  }

  Future<void> fetchReels() async {
    isLoading(true);
    final result = await ReelsService.getReelsFeed();
    AppLogger.debug('reels: $result');
    reels.assignAll(result);

    // Eagerly pre-init the first reel so it's ready the instant the UI builds.
    if (reels.isNotEmpty) {
      _preInitForUrl(reels[0].reelMediaUrl);
    }

    isLoading(false);
  }

  /// Called by the [PageView.onPageChanged] callback in [ReelsView].
  ///
  /// Performs three operations in order:
  /// 1. Pre-caches the videos at `index + 1` and `index + 2`.
  /// 2. Pre-initializes the native decoder for `index + 1`.
  /// 3. Disposes any controllers outside the `[index-1, index+1]` window.
  void onPageChanged(int index) {
    _preCacheAhead(index);
    _preInitAhead(index);
    _enforceRuleOfThree(index);
  }

  /// Pre-caches the next two reels so they are ready when the user swipes.
  void _preCacheAhead(int currentIndex) {
    for (int offset = 1; offset <= 2; offset++) {
      final targetIndex = currentIndex + offset;
      if (targetIndex < reels.length) {
        VideoService.to.preCacheVideo(reels[targetIndex].reelMediaUrl);
      }
    }
  }

  /// Eagerly initializes [MyVideoController] for the next reel.
  ///
  /// Because the video file is already disk-cached (via [_preCacheAhead]),
  /// this initialization is essentially just setting up the native decoder
  /// (~50-100 ms from disk), making the transition completely seamless.
  void _preInitAhead(int currentIndex) {
    final nextIndex = currentIndex + 1;
    if (nextIndex < reels.length) {
      _preInitForUrl(reels[nextIndex].reelMediaUrl);
    }
  }

  /// Creates and starts initializing a [MyVideoController] for [url] if one
  /// doesn't already exist in the pre-init cache.
  void _preInitForUrl(String url) {
    if (_preInitControllers.containsKey(url)) return;
    final ctrl = MyVideoController(videoUrl: url);
    _preInitControllers[url] = ctrl;
    ctrl.initialize(); // fire-and-forget; idempotent if called again
  }

  /// Returns (and removes) a pre-initialized controller for [url], or `null`.
  ///
  /// Called by [ReelPlayerController.onInit] to claim a warm controller
  /// instead of creating a cold one from scratch.
  MyVideoController? takePreInitController(String url) {
    return _preInitControllers.remove(url);
  }

  /// Disposes every controller outside the `[i-1, i+1]` window.
  ///
  /// This guarantees that at most 3 controllers are alive at any time,
  /// preventing native video decoder OOM crashes on lower-end devices.
  void _enforceRuleOfThree(int currentIndex) {
    final keepRange = {currentIndex - 1, currentIndex, currentIndex + 1};

    final indicesToRemove =
        _activeControllers.keys.where((i) => !keepRange.contains(i)).toList();

    for (final i in indicesToRemove) {
      AppLogger.debug('🗑️ [MEMORY]: Disposing controller at index $i');
      _activeControllers[i]?.disposeVideo();
      _activeControllers.remove(i);
    }
  }

  /// Registers a [MyVideoController] so the reels controller can manage its lifecycle.
  ///
  /// Called by [ReelPlayerWidget] or [ReelPlayerItemView] after creating a controller.
  void registerController(int index, MyVideoController controller) {
    _activeControllers[index] = controller;
  }

  /// Disposes **every** active video controller and pre-initialized controller.
  ///
  /// Used when the user switches bottom-navigation tabs or leaves the reels
  /// screen entirely. This is the nuclear cleanup option.
  void cleanupAllVideos() {
    for (final controller in _activeControllers.values) {
      controller.disposeVideo();
    }
    _activeControllers.clear();

    for (final controller in _preInitControllers.values) {
      controller.disposeVideo();
    }
    _preInitControllers.clear();
  }

  Future<void> uploadReel(File videoFile) async {
    final newReel = await ReelsService.uploadReel(videoFile);
    if (newReel != null) {
      reels.insert(0, newReel);
      update(['reels_list']);
    }
  }

  Future<void> deleteReel(String id) async {
    final success = await ReelsService.deleteReel(id);
    if (success) {
      reels.removeWhere((reel) => reel.id == id);
      update(['reels_list']);
    }
  }

  @override
  void onClose() {
    cleanupAllVideos();
    super.onClose();
  }
}

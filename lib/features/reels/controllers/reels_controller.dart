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

    isLoading(false);
  }

  /// Called by the [PageView.onPageChanged] callback in [ReelsView].
  ///
  /// Performs three operations in order:
  /// 1. Pre-caches the videos at `index + 1` and `index + 2`.
  /// 2. Disposes any controllers outside the `[index-1, index+1]` window.
  /// 3. Registers the current index's controller if not already tracked.
  void onPageChanged(int index) {
    _preCacheAhead(index);
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

  /// Disposes **every** active video controller.
  ///
  /// Used when the user switches bottom-navigation tabs or leaves the reels
  /// screen entirely. This is the nuclear cleanup option.
  void cleanupAllVideos() {
    for (final controller in _activeControllers.values) {
      controller.disposeVideo();
    }
    _activeControllers.clear();
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

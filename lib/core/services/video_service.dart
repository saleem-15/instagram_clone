import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:instagram_clone/core/utils/constants/api.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:instagram_clone/core/utils/logger.dart';

/// A customized [CacheManager] specifically tailored for managing video files.
///
/// This singleton ensures that all video caching operations use the same
/// configuration, which limits the cache size (e.g. up to 50 objects) and
/// sets a stale period (time to keep the file in cache) of 3 days. 
/// It automatically clears out old videos
/// preventing the device storage from getting completely filled up.
class CustomCacheManager extends CacheManager {
  static const key = 'customVideoCache';

  static final CustomCacheManager _instance = CustomCacheManager._();
  factory CustomCacheManager() {
    return _instance;
  }

  CustomCacheManager._()
      : super(Config(
          key,
          stalePeriod: const Duration(days: 3),
          maxNrOfCacheObjects: 50,
          // maxSize: 250 * 1024 * 1024, // Config doesn't support maxSize parameter natively in flutter_cache_manager, handling via maxNrOfCacheObjects
        ));
}

/// A centralized service for managing [VideoPlayerController] instances globally.
///
/// It uses a reference counting mechanism to ensure that controllers are shared
/// across different widgets requesting the same video URL. It also integrates
/// heavily with [CustomCacheManager] to automatically cache videos and seamlessly
/// fallback to network playback when the cache is empty.
class VideoService extends GetxService {
  static VideoService get to => Get.find();

  final Map<String, VideoPlayerController> _controllers = {};
  final Map<String, int> _refCounts = {};

  /// Checks the local cache for a completely downloaded video file.
  ///
  /// Returns a [FileInfo] containing the file object if found, or null
  /// if the video is not cached yet.
  Future<FileInfo?> getCachedVideo(String url) async {
    return await CustomCacheManager().getFileFromCache(url);
  }

  /// Downloads a video in the background without playing it.
  ///
  /// If the video is already completely downloaded, it does nothing.
  /// If the download fails or the file gets corrupted during download,
  /// it is automatically removed from the cache to prevent playback errors later.
  Future<void> preCacheVideo(String url) async {
    try {
      final fileInfo = await getCachedVideo(url);
      if (fileInfo == null) {
        await CustomCacheManager().downloadFile(url);
      }
    } catch (e) {
      // If a download fails, discard the corrupted file
      await CustomCacheManager().removeFile(url);
    }
  }

  /// Retrieves a managed [VideoPlayerController] for the given [url].
  ///
  /// If a controller for this URL is already open, it increments its reference
  /// count and returns the existing instance.
  /// If it needs to create a new controller, it checks the [CustomCacheManager].
  /// If the video is cached locally, it plays from the local file system.
  /// Otherwise, it streams over the network.
  Future<VideoPlayerController> getController(String url) async {
    // Increment reference count
    _refCounts[url] = (_refCounts[url] ?? 0) + 1;

    if (_controllers.containsKey(url)) {
      return _controllers[url]!;
    }

    final fileInfo = await getCachedVideo(url);
    VideoPlayerController controller;

    if (fileInfo != null) {
      AppLogger.success('✅ [VIDEO CACHE HIT]: Playing from File');
      controller = VideoPlayerController.file(fileInfo.file);
    } else {
      AppLogger.info('🌐 [VIDEO CACHE MISS]: Fetching from Network');
      controller = VideoPlayerController.networkUrl(
        Uri.parse(url),
        httpHeaders: Api.headers,
      );
    }

    _controllers[url] = controller;
    await controller.initialize();

    return controller;
  }

  /// Decrements the reference count for the controller associated with the [url].
  ///
  /// When the reference count drops to zero, the controller is properly disposed
  /// and released from memory.
  void releaseController(String url) {
    if (!_refCounts.containsKey(url)) return;

    _refCounts[url] = _refCounts[url]! - 1;

    if (_refCounts[url]! <= 0) {
      _controllers[url]?.dispose();
      _controllers.remove(url);
      _refCounts.remove(url);
    }
  }

  @override
  void onClose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    _controllers.clear();
    _refCounts.clear();
    super.onClose();
  }
}

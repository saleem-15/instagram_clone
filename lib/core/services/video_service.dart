import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';

class VideoService extends GetxService {
  static VideoService get to => Get.find();

  final DefaultCacheManager _cacheManager = DefaultCacheManager();

  /// Gets the cached video file if it exists.
  Future<FileInfo?> getCachedVideo(String url) async {
    return await _cacheManager.getFileFromCache(url);
  }

  /// Triggers a background download to cache the video.
  void cacheVideo(String url) {
    // Fire and forget caching
    _cacheManager.downloadFile(url).catchError((e) {
      Get.log('Video caching failed for $url: $e');
      throw e;
    });
  }
}

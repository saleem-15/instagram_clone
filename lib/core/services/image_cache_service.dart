import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:instagram_clone/core/utils/logger.dart';

class ImageCacheService {
  // Singleton pattern
  static final ImageCacheService _instance = ImageCacheService._internal();

  factory ImageCacheService() {
    return _instance;
  }

  ImageCacheService._internal();

  // Static custom CacheManager instance
  static final CacheManager imageManager = CacheManager(
    Config(
      'customImageCache',
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 200,
    ),
  );

  /// Clears all cached images from the custom image cache.
  Future<void> clearCache() async {
    await imageManager.emptyCache();
    AppLogger.success('🗑️ [IMAGE CACHE]: All cached images cleared successfully');
  }
}

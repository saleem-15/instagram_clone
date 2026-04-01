import 'package:flutter_cache_manager/flutter_cache_manager.dart';

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
}

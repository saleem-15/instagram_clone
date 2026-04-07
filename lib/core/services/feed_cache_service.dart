import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:instagram_clone/core/models/post.dart';
import 'package:instagram_clone/core/models/reel.dart';
import 'package:instagram_clone/core/utils/logger.dart';

class FeedCacheService {
  // Singleton pattern
  static final FeedCacheService _instance = FeedCacheService._internal();
  factory FeedCacheService() => _instance;
  FeedCacheService._internal();

  late Isar isar;

  /// Initializes the Isar database instance.
  /// Should be called during app startup (e.g., in main.dart).
  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    
    // Check if an instance is already open to avoid errors
    if (Isar.instanceNames.isEmpty) {
      isar = await Isar.open(
        [PostSchema, ReelSchema],
        directory: dir.path,
        inspector: true, // Enables Isar Inspector for debugging in dev
      );
    } else {
      isar = Isar.getInstance()!;
    }
  }

  // --- Home Feed Caching ---

  /// Clears existing cached posts and saves the top 20 posts for offline access.
  Future<void> cacheHomeFeed(List<Post> posts) async {
    await isar.writeTxn(() async {
      // Clear old cache to keep it fresh and lightweight
      await isar.posts.clear();
      
      // Save only the top 20 posts to save storage space
      final topPosts = posts.take(20).toList();
      await isar.posts.putAll(topPosts);
    });
  }

  /// Retrieves the saved posts from the local Isar cache.
  Future<List<Post>> getCachedHomeFeed() async {
    final posts = await isar.posts.where().findAll();
    AppLogger.success('📦 [ISAR]: Loaded ${posts.length} posts from local DB');
    return posts;
  }

  // --- Reels Feed Caching ---

  /// Clears existing cached reels and saves the top 20 reels for offline access.
  Future<void> cacheReelsFeed(List<Reel> reels) async {
    await isar.writeTxn(() async {
      // Clear old cache
      await isar.reels.clear();
      
      // Save top 20 reels
      final topReels = reels.take(20).toList();
      await isar.reels.putAll(topReels);
    });
  }

  /// Retrieves the saved reels from the local Isar cache.
  Future<List<Reel>> getCachedReelsFeed() async {
    final reelsList = await isar.reels.where().findAll();
    AppLogger.success('📦 [ISAR]: Loaded ${reelsList.length} reels from local DB');
    return reelsList;
  }

  /// Clears all cached feed data (both posts and reels).
  /// Useful for development and manual cache clearing.
  Future<void> clearCache() async {
    await isar.writeTxn(() async {
      await isar.posts.clear();
      await isar.reels.clear();
    });
    AppLogger.success('🗑️ [ISAR]: Cached feed data cleared successfully');
  }
}

import 'dart:convert';

import 'package:instagram_clone/core/models/post.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// A database-backed caching service for the home feed.
///
/// Uses [sqflite] for efficient structured storage of post data so the
/// feed can render instantly on cold start before the network response
/// arrives.
class CacheService {
  late final Database _db;

  static const String _tablePosts = 'cached_posts';
  static const String _tableMeta = 'cache_meta';

  /// Opens (or creates) the cache database.
  Future<CacheService> init() async {
    final dbPath = join(await getDatabasesPath(), 'instagram_cache.db');

    _db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tablePosts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            post_id TEXT UNIQUE,
            data TEXT NOT NULL,
            sort_order INTEGER NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE $_tableMeta (
            key TEXT PRIMARY KEY,
            value INTEGER NOT NULL
          )
        ''');
      },
    );

    return this;
  }

  // ─── Posts ────────────────────────────────────────────────────────────

  /// Persists a list of [Post] objects into the database.
  ///
  /// Each post is stored as a JSON blob keyed by its `post_id`.
  Future<void> cachePosts(List<Post> posts) async {
    final batch = _db.batch();
    for (var i = 0; i < posts.length; i++) {
      batch.insert(
        _tablePosts,
        {
          'post_id': posts[i].id,
          'data': jsonEncode(posts[i].toMap()),
          'sort_order': i,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  /// Returns any previously cached posts ordered by their original sort order.
  Future<List<Post>> getCachedPosts() async {
    final rows = await _db.query(
      _tablePosts,
      orderBy: 'sort_order ASC',
    );

    return rows.map((row) {
      final map = jsonDecode(row['data'] as String) as Map<String, dynamic>;
      return Post.fromMap(map);
    }).toList();
  }

  /// Removes all cached posts and pagination metadata (used on pull‑to‑refresh).
  Future<void> clearPostsCache() async {
    await _db.delete(_tablePosts);
    await _db.delete(_tableMeta);
  }

  // ─── Pagination metadata ─────────────────────────────────────────────

  Future<void> cacheLastPage(int lastPage) async {
    await _db.insert(
      _tableMeta,
      {'key': 'last_page', 'value': lastPage},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> getCachedLastPage() async {
    final rows = await _db.query(
      _tableMeta,
      where: 'key = ?',
      whereArgs: ['last_page'],
    );
    if (rows.isEmpty) return 1;
    return rows.first['value'] as int;
  }

  Future<void> cacheCurrentPage(int page) async {
    await _db.insert(
      _tableMeta,
      {'key': 'current_page', 'value': page},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> getCachedCurrentPage() async {
    final rows = await _db.query(
      _tableMeta,
      where: 'key = ?',
      whereArgs: ['current_page'],
    );
    if (rows.isEmpty) return 1;
    return rows.first['value'] as int;
  }
}

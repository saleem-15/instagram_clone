import 'package:instagram_clone/core/models/story.dart';
import 'package:isar/isar.dart';
import 'package:instagram_clone/core/models/user.dart';

part 'reel.g.dart';

@collection
class Reel {
  /// Internal Isar ID required for 64-bit local storage.
  /// The primary reason for adding a separate isarId instead of using the existing id is a technical requirement of the Isar database:
  ///
  /// Isar uses 64-bit integers (longs) for its internal primary keys (Id) to ensure efficient indexing and storage, especially on 64-bit systems.
  ///
  /// The id field from your API is a String (e.g., "12345").
  ///
  /// You cannot directly use a String as an Isar Id because:
  ///
  /// Type Mismatch: Isar expects an int for the Id field.
  ///
  /// Performance: String-based primary keys are much slower for indexing and lookups compared to native integer keys.
  ///
  /// Storage: Storing strings as primary keys consumes significantly more memory and disk space.
  ///
  /// Solution: By adding a separate isarId field of type int, 
  /// you let Isar manage its own efficient internal primary key 
  /// while still using your API's id for unique identification and conflict resolution.
  Id isarId = Isar.autoIncrement;

  /// Unique API String ID. Indexed for fast local lookups and conflict resolution.
  @Index(unique: true, replace: true)
  final String id;
  final String reelMediaUrl;
  final User user;

  bool isFavorite;
  bool isSaved;
  int numOfLikes;
  int numOfComments;
  String caption;

  Reel({
    required this.id,
    required this.reelMediaUrl,
    required this.user,
    this.isFavorite = false,
    this.isSaved = false,
    this.numOfLikes = 0,
    this.numOfComments = 0,
    this.caption = '',
  });

  factory Reel.fromMap(Map<String, dynamic> map) {
    return Reel(
      id: map['reels_id'].toString(),
      reelMediaUrl: map['reels'],
      user: User.fromMap(map['user']),
      isFavorite: map['is_favorite'] ?? false,
      isSaved: map['is_saved'] ?? false, // Defaulting if API lacks it
      numOfLikes: map['likes_num'] ?? 0,
      numOfComments: map['num_of_comments'] ?? 0,
      caption: map['caption'] ?? '',
    );
  }
}

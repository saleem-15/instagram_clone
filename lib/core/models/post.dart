import 'package:instagram_clone/core/models/story.dart';
import 'package:isar/isar.dart';
import 'package:instagram_clone/core/utils/constants/api.dart';
import 'user.dart';

part 'post.g.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

@collection
class Post {
  /// Internal Isar ID required for 64-bit local storage.
  Id isarId = Isar.autoIncrement;

  /// Unique API String ID. Indexed for fast local lookups and conflict resolution.
  @Index(unique: true, replace: true)
  String id;
  User user;
  bool isFavorite;
  bool isSaved;
  int numOfLikes;
  int numOfComments;
  String caption;

  /// content of the post
  List<String> postContents;

  Post({
    required this.id,
    required this.user,
    required this.isFavorite,
    required this.isSaved,
    required this.numOfLikes,
    required this.numOfComments,
    required this.caption,
    required this.postContents,
  });

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['post_id'].toString(),
      user: User.fromMap(map['user']),
      isFavorite: map['is_favorite'],
      //
      isSaved: false,
      //
      numOfLikes: map['likes_num'],
      numOfComments: map['num_of_comments'],
      postContents: List<String>.from(map['post_media'])
          .map((e) => Api.normalizeUrl(e))
          .toList(),
      caption: map['caption'],
    );
  }
}

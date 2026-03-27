import 'package:instagram_clone/core/models/user.dart';

class Reel {
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

import 'user.dart';

class Post {
  String id;
  User user;
  bool isFavorite;
  bool isSaved;
  int numOfLikes;
  int numOfComments;

  /// content of the post
  List<String>? photos;
  List<String>? videos;

  Post({
    required this.id,
    required this.user,
    required this.isFavorite,
    required this.isSaved,
    required this.numOfLikes,
    required this.numOfComments,
    this.photos,
    this.videos,
  });
}

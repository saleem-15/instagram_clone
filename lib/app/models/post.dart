// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'user.dart';

class Post {
  String id;
  User user;
  bool isFavorite;
  bool isSaved;
  int numOfLikes;
  int numOfComments;

  /// content of the post
  List<String> postContents;

  Post({
    required this.id,
    required this.user,
    required this.isFavorite,
    required this.isSaved,
    required this.numOfLikes,
    required this.numOfComments,
    required this.postContents,
  });

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'].toString(),
      user: User.fromMap(map['user']),
      isFavorite: map['isFavorite'],
      isSaved: map['isSaved'],
      numOfLikes: map['numOfLikes'],
      numOfComments: map['numOfComments'],
      postContents: List<String>.from(map['photos']),
    );
  }
}

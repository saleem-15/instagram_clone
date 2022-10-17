// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:instagram_clone/utils/constants/api.dart';

import 'user.dart';

class Post {
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
      isFavorite:true,
      //  map['isFavorite'],
      isSaved: false,
      // map['isSaved'],
      numOfLikes: 5,
      //  map['numOfLikes'],
      numOfComments: 10,
      //  map['numOfComments'],
      postContents: List<String>.from(map['post_media']).map((e) => 'http://$myIp:80/${e.substring(9)}').toList(),
      caption:  map['caption'],
    );
  }
}

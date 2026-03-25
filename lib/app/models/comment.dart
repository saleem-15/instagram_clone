import 'package:get/get.dart';
import 'package:instagram_clone/app/models/user.dart';

class Comment {
  String id;
  User user;
  String text;
  String createdAt;
  RxBool isCommentLiked ;

  Comment({
    required this.id,
    required this.user,
    required this.text,
    required this.createdAt,
    required this.isCommentLiked,
  });

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['comment_id'].toString(),
      user: User.fromMap(map['user']),
      text: map['comment'],
      createdAt: map['created_before'],
      isCommentLiked: false.obs,
    );
  }
}

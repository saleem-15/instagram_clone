import 'package:instagram_clone/app/models/user.dart';

class Comment {
  String id;
  // String postId;
  User user;
  String text;

  Comment({
    required this.id,
    // required this.postId,
    required this.user,
    required this.text,
  });

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['comment_id'].toString(),
      // postId: map['postId'].toString(),
      user: User.fromMap(map['user']),
      text: map['comment'],
    );
  }
}

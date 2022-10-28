import 'package:instagram_clone/app/models/user.dart';

class Comment {
  String id;
  User user;
  String text;

  Comment({
    required this.id,
    required this.user,
    required this.text,
  });

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['comment_id'].toString(),
      user: User.fromMap(map['user']),
      text: map['comment'],
    );
  }
}

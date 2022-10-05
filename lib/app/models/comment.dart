import 'dart:convert';

import 'package:instagram_clone/app/models/user.dart';

class Comment {
  String id;
  String postId;
  User user;
  String text;

  Comment({
    required this.id,
    required this.postId,
    required this.user,
    required this.text,
  });
}

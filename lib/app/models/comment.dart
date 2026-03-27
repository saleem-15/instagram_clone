import 'package:get/get.dart';
import 'package:instagram_clone/app/models/user.dart';

class Comment {
  String id;
  User user;
  String text;
  String createdAt;
  RxBool isCommentLiked;
  RxInt numOfReplies;
  RxList<Comment> replies = <Comment>[].obs;
  RxBool isRepliesVisible = false.obs;

  Comment({
    required this.id,
    required this.user,
    required this.text,
    required this.createdAt,
    required this.isCommentLiked,
    required this.numOfReplies,
  });

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: (map['comment_id'] ?? map['id']).toString(),
      user: User.fromMap(map['user'] ?? map['User'] ?? {}),
      text: map['comment'] ?? map['reply'] ?? '',
      createdAt: map['created_before'] ?? map['created_at'] ?? 'Just now',
      isCommentLiked: false.obs,
      numOfReplies:
          (int.tryParse(map['num_of_replies']?.toString() ?? '0') ?? 0).obs,
    );
  }
}

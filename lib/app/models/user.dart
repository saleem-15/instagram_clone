// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

class User {
  String id;
  String userName;
  String nickName;
  String? image;
  bool isHasNewStory;
  User({
    required this.id,
    required this.userName,
    required this.nickName,
    required this.image,
    this.isHasNewStory = true,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: (map['user_id'] ?? map['id']).toString(),
      userName: map['name'],
      nickName: map['nick_name'],
      image: _getImage(map['image_url']),
    );
  }

  @override
  String toString() {
    return '${'user_id: $id\nname: $userName\nnickName: $nickName\nHas_New_Story: $isHasNewStory'}\nimage: $image';
  }

  static String? _getImage(String? image) {
    if (image == null) {
      return null;
    }
    final last = image.split('/').last;
    if (last == 'default.png' || last.isBlank!) {
      return null;
    }
    return image;
  }
}

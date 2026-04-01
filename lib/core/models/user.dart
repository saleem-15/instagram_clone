import 'package:isar/isar.dart';
import 'package:instagram_clone/core/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/models/story.dart';

part 'user.g.dart';

/// User model annotated for Isar embedding.
@embedded
class User {
  /// API User ID. Defaulted for Isar compatibility.
  String id = '';
  String userName;
  String nickName;
  String? image;
  bool doIFollowHim;
  List<Story> userStories;
  bool get isHasNewStory => userStories.any((story) => !story.isWathced);
  bool get isMe => Get.find<StorageService>().getUserId == id;

  User({
    this.id = '',
    this.userName = '',
    this.nickName = '',
    this.image,
    this.doIFollowHim = false,
    this.userStories = const [],
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: (map['user_id'] ?? map['id']).toString(),
      userName: map['name'] ?? '',
      nickName: map['nick_name'] ?? '',
      image: _getImage(map['image_url']),
      userStories: Story.storiesListFromMap(map['user_stories'] ?? []),
      doIFollowHim: map['youFollowHim'] ?? false,
    );
  }

  static List<User> usersListFromJson(List data) {
    List<User> users = [];
    for (final userData in data) {
      users.add(User.fromMap(userData));
    }

    return users;
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

  @override
  String toString() {
    return '${'user_id: $id\nname: $userName\nnickName: $nickName\nHas_New_Story: $isHasNewStory'}\nimage: $image';
  }
}

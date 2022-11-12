import 'package:get/get.dart';
import 'package:instagram_clone/app/models/story.dart';
import 'package:instagram_clone/app/storage/my_shared_pref.dart';

class User {
  String id;
  String userName;
  String nickName;
  String? image;
  bool doIFollowHim;
  List<Story> userStories;
  bool get isHasNewStory => userStories.any((story) => !story.isWathced);
  bool get isMe => MySharedPref.getUserId == id;

  User({
    required this.id,
    required this.userName,
    required this.nickName,
    required this.image,
    required this.doIFollowHim,
    required this.userStories,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    // //if it was me
    // if (map['name'] == null) {
    //   return MySharedPref.getUserData!;
    // }
    return User(
      id: (map['user_id'] ?? map['id']).toString(),
      userName: map['name'],
      nickName: map['nick_name'],
      image: _getImage(map['image_url']),
      userStories: Story.storiesListFromMap(map['user_stories'] ?? []),

      /// map['youFollowHim'] is null when its your profile/user info
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

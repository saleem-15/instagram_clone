import 'dart:developer';

import 'package:instagram_clone/app/storage/my_shared_pref.dart';

import 'user.dart';

class Profile {
  String nickName;
  String? bio;
  int numOfPost;
  int numOfFollowers;
  int numOfFollowings;
  bool doIFollowHim;

  User user;
  String get userName => user.userName;
  String get userId => user.id;
  bool get isHasNewStory => user.isHasNewStory;
  String? get image => user.image;

  Profile({
    required this.nickName,
    required this.bio,
    required this.numOfPost,
    required this.numOfFollowers,
    required this.numOfFollowings,
    required this.doIFollowHim,
    required this.user,
  });

  factory Profile.fromMap(Map<String, dynamic> map) {
    final user = User.fromMap(map);
    final isMe = MySharedPref.getUserId == user.id;
    log('is My profile: $isMe');
    return Profile(
      nickName: map['nick_name'],
      bio: map['bio'],
      numOfPost: map['posts_num'],
      numOfFollowers: map['followers_num'],
      numOfFollowings: map['following_num'],
      user: user,

      /// this field dows not exist if its my profile
      /// so i set it to false
      doIFollowHim: isMe ? false : map['youFollowHim'],
    );
  }
}

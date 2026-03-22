import 'package:instagram_clone/app/models/user.dart';

class Reel {
  final String id;
  final String reelMediaUrl;
  final User user;

  Reel({
    required this.id,
    required this.reelMediaUrl,
    required this.user,
  });

  factory Reel.fromMap(Map<String, dynamic> map) {
    return Reel(
      id: map['reels_id'].toString(),
      reelMediaUrl: map['reels'],
      user: User.fromMap(map['user']),
    );
  }
}

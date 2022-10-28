import 'package:get/utils.dart';

class Story {
  String id;

  /// url to the media (photo /video)
  String media;

  bool get isPhoto => media.isImageFileName;

  Story({
    required this.id,
    required this.media,
  });

  factory Story.fromMap(Map<String, dynamic> map) {
    return Story(
      id: map['story_id'].toString(),
      media: map['media'],
    );
  }
}

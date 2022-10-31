// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/utils.dart';

class Story {
  String id;

  /// url to the media (photo /video)
  String media;
  bool isWathced;

  bool get isPhoto => media.isImageFileName;

  Story({
    required this.id,
    required this.media,
    required this.isWathced,
  });

  factory Story.fromMap(Map<String, dynamic> map) {
    return Story(
      id: map['story_id'].toString(),
      media: map['media'],
      isWathced: false,
    );
  }
}

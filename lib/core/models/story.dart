import 'package:isar/isar.dart';
import 'package:get/utils.dart';
import 'package:instagram_clone/core/utils/constants/api.dart';

part 'story.g.dart';

/// Story model annotated for Isar embedding.
@embedded
class Story {
  /// API Story ID. Defaulted for Isar compatibility.
  String id = '';

  /// url to the media (photo /video)
  String media;
  bool isWathced;

  bool get isPhoto => media.isImageFileName;

  Story({
    this.id = '',
    this.media = '',
    this.isWathced = false,
  });

  factory Story.fromMap(Map<String, dynamic> map) {
    return Story(
      id: map['story_id']?.toString() ?? '',
      media: Api.normalizeUrl(map['media'] ?? ''),
      isWathced: map['is_watched'] ?? false,
    );
  }
  static List<Story> storiesListFromMap(List data) {
    List<Story> stories = [];
    for (var story in data) {
      stories.add(Story.fromMap(story));
    }

    return stories;
  }
}

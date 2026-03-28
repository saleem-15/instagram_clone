import 'package:instagram_clone/core/services/api_service.dart';
import 'package:instagram_clone/core/utils/constants/api.dart';
import 'package:instagram_clone/core/network/api_exception.dart';

/// Marks a specific story identified by [storyId] as watched by the current user.
/// Returns `true` if the request was successful, `false` otherwise.
Future<bool> setStoryAsWatchedService(String storyId) async {
  try {
    await ApiService.to.post(
      Api.SET_STORY_AS_WATCHED_URL,
      queryParameters: {'story_id': storyId},
    );
    return true;
  } on ApiException {
    // Fail silently for analytics/state updates in this specific service
    return false;
  }
}

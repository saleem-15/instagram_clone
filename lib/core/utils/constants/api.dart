import 'package:instagram_clone/core/services/storage_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

/// [Api] contains all constants related to API endpoints and configurations.
class Api {
  /// The base URL for the API, loaded from .env or defaulting to localhost.
  static String get apiUrl => dotenv.env['API_URL']!;

  /// The API key for requests, loaded from .env.
  static String get apikey => dotenv.env['API_KEY']!;

  // Auth endpoints
  static const SIGN_IN_URL = '/auth/user/login';
  static const SIGN_UP_URL = '/auth/user/register';
  static const MY_INFO = '/auth/user/info';
  static const LOGOUT_URL = '/auth/user/logout';
  static const FORGET_PASSWORD_URL = '/auth/user/password/code/send';
  static const CHECK_EMAIL_CODE_URL = '/auth/user/password/code/check';
  static const RESET_PASSWORD_URL = '/auth/user/password/reset';
  static const EDIT_PROFILE_URL = '/auth/user';

  // User endpoints
  static const USER_URL = '/user';

  // Post endpoints
  static const POST_URL = '/post';
  static const MARK_POST_AS_FAVORITE_URL = '/post/like';
  static const SAVE_POST_URL = '/post/save';
  // Comment endpoints
  static const COMMENTS_URL = '/comment';
  static const COMMENT_REPLY_URL = '/comment/reply';

  // Search endpoints
  static const SEARCH_PATH = '/user/search';
  static const SEARCH_HISTORY_URL = '/search/history/';

  // Story endpoints
  static const STORY_URL = '/story';
  static const SET_STORY_AS_WATCHED_URL = '/story/view';

  // Reels endpoints
  static const REELS_URL = '/reels';
  static const REELS_USER_URL = '/reels/user';
  static const REELS_FEED_URL = '/reels/feed';

  // Profile endpoints
  static const PROFILE_PATH = '/profile';
  static const PROFILE_POSTS_URL = '/profile/posts';

  // Follow endpoints
  static const FOLLOWERS_PATH = '/followers';
  static const SEARCH_FOLLOWERS_PATH = '/followers/search';
  static const FOLLOWING_PATH = '/following';
  static const SEARCH_FOLLOWING_PATH = '/following/search';
  static const FOLLOW_USER_PATH = '/follow';

  /// Fixes media URLs from the backend.
  ///
  /// The backend always prepends its storage path to image URLs stored in the DB.
  /// When the DB already contains an absolute URL (e.g. from Gravatar/Pravatar),
  /// the result is a broken nested URL like:
  ///   `http://10.15.4.120:8000/img/users/profile/https://i.pravatar.cc/300?u=saleem`
  ///
  /// This method detects nested protocols and extracts the real URL.
  /// For relative paths (no protocol at all), it prepends [apiUrl].
  static String normalizeUrl(String url) {
    if (url.isEmpty) return url;

    // Find the LAST occurrence of http:// or https://
    // If there are two protocols, the second one is the real URL.
    final httpsIndex = url.lastIndexOf('https://');
    final httpIndex = url.lastIndexOf('http://');
    final lastProtocol = httpsIndex > httpIndex ? httpsIndex : httpIndex;

    // If a protocol exists and it's NOT at position 0, it's nested → extract it
    if (lastProtocol > 0) {
      return url.substring(lastProtocol);
    }

    // If a protocol exists at position 0, the URL is already valid
    if (lastProtocol == 0) {
      return url;
    }

    // No protocol found → relative path, prepend base URL
    final cleanPath = url.startsWith('/') ? url : '/$url';
    final base =
        apiUrl.endsWith('/') ? apiUrl.substring(0, apiUrl.length - 1) : apiUrl;
    return '$base$cleanPath';
  }

  /// Returns a map of standard headers including the authentication token.
  /// Useful for widgets like [CachedNetworkImage] or [VideoPlayer] that need headers.
  static Map<String, String> get headers => {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'apiKey': Api.apikey,
        'Authorization': 'Bearer ${Get.find<StorageService>().getToken}',
        "ngrok-skip-browser-warning": "any-value",
      };
}

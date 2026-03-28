import 'package:instagram_clone/core/services/storage_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

/// [Api] contains all constants related to API endpoints and configurations.
class Api {
  /// The base URL for the API, loaded from .env or defaulting to localhost.
  static String get apiUrl =>
      dotenv.env['API_URL'] ?? "http://10.15.4.41:8000/api";

  /// The API key for requests, loaded from .env.
  static String get apikey => dotenv.env['API_KEY'] ?? 'p@ssword123';

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

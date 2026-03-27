import 'package:instagram_clone/core/services/storage_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class Api {
  static String get apiUrl => dotenv.env['API_URL'] ?? "http://10.15.4.41:8000/api";
  static String get apikey => dotenv.env['API_KEY'] ?? 'p@ssword123';

  static const SIGN_IN_URL = '/auth/user/login';
  static const SIGN_UP_URL = '/auth/user/register';
  static const MY_INFO = '/auth/user/info';
  static const LOGOUT_URL = '/auth/user/logout';
  static const FORGET_PASSWORD_URL = '/auth/user/password/code/send';
  static const CHECK_EMAIL_CODE_URL = '/auth/user/password/code/check';
  static const RESET_PASSWORD_URL = '/auth/user/password/reset';
  static const EDIT_PROFILE_URL = '/auth/user';

//user
  static const USER_URL = '/user';

//post
  static const POST_URL = '/post';
  static const MARK_POST_AS_FAVORITE_URL = '/post/like';

//SAVE POST
  static const SAVE_POST_URL = '/post/save';

//comments
  static const COMMNETS_URL = '/comment';
  static const COMMENT_REPLY_URL = '/comment/reply';

//search
  static const SEARCH_URL = '/user/search';
  static const SEARCH_HISTORY_URL = '/search/history/';

//story
  static const STORY_URL = '/story';
  static const SET_STORY_AS_WATHCED_URL = '/story/view';

//reels
  static const REELS_URL = '/reels';
  static const REELS_USER_URL = '/reels/user';
  static const REELS_FEED_URL = '/reels/feed';

//profile
  static const PROFILE_PATH = '/profile';
  static const PROFILE_POSTS_URL = '/profile/posts';

//follow
  static const FOLLOWERS_PATH = '/followers';
  static const SEARCH_FOLLOWERS_PATH = '/followers/search';
  static const FOLLOWEING_PATH = '/following';
  static const SEARCH_FOLLOWEING_PATH = '/following/search';
  static const FOLLOW_USER_PATH = '/follow';

//search
  static const SEARCH_PATH = '/user/search';

  static Map<String, String> get headers => {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'apiKey': Api.apikey,
    'Authorization': 'Bearer ${Get.find<StorageService>().getToken}',
    "ngrok-skip-browser-warning": "any-value",
  };
}

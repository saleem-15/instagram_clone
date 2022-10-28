import 'package:dio/dio.dart';

import 'package:instagram_clone/app/storage/my_shared_pref.dart';

class Api {
// const baseUrl = '10.0.0.200';
// const baseUrl = '10.0.0.9:80';
// const baseUrl = 'fe80::fe6a:4e4a:2b4b:e006%9';

// static const apiUrl = 'https://10.0.96.53/laravel9/instagram/public/api';
  static const apiUrl = 'https://instagram-clone.devyzer.com/api';
  static const apikey = 'p@ssword123';

//auth
  static const SIGN_IN_URL = '/auth/user/login';
  static const SIGN_UP_URL = '/auth/user/register';
  static const MY_INFO = '/auth/user/info';
  static const LOGOUT_URL = '/auth/user/logout';

//user
  static const USER_URL = '/user';

//post
  static const POST_URL = '/post';
  static const MARK_POST_AS_FAVORITE_URL = '/post/like';

//SAVE POST
  static const SAVE_POST_URL = '/post/save';
  
//comments
  static const COMMNETS_URL = '/comment';

//search
  static const SEARCH_URL = '/user/search';
  

//story
  static const STORY_URL = '/story';

//profile
  static const PROFILE_PATH = '/profile';
  static const PROFILE_POSTS_URL = '/profile/posts';

//follow
  static const FOLLOWERS_PATH = '/followers';
  static const FOLLOWEING_PATH = '/following';
  static const FOLLOW_USER_PATH = '/follow';

//search
  static const SEARCH_PATH = '/user/search';

  static Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'apiKey': Api.apikey,
    'Authorization': 'Bearer ${MySharedPref.getToken}',
  };

  /// this method is must called when the (Token) is changed
  ///
  /// OR YOU WILL HAVE AUTHORIZATION ISSUES WITH THE API
  static void authChanged() {
    headers['Authorization'] = 'Bearer ${MySharedPref.getToken}';
    dio.options.headers = Api.headers;
  }
}

final dio = Dio(
  BaseOptions(
    baseUrl: Api.apiUrl,
    receiveTimeout: 20000,
    connectTimeout: 20000,
    sendTimeout: 10000,
    headers: Api.headers,
  ),
);

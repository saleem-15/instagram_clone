import 'package:dio/dio.dart';

import '../../app/storage/my_shared_pref.dart';

const apiUrl = 'http://10.0.0.8:80/laravel9/instagram/public/api';
const apikey = 'p@ssword123';

//auth
const SIGN_IN_URL = '/auth/user/login';
const SIGN_UP_URL = '/auth/user/register';
const LOGOUT_URL = '/auth/user/logout';

//post
const POST_URL = '';
// const POST_URL = '';

//
const COMMNETS_URL = '';

//profile
const USER_PATH = '';
const FOLLOWERS_PATH = '';
const FOLLOWEING_PATH = '';

//search
const SEARCH_PATH = '';

final dio = Dio(
  BaseOptions(
    baseUrl: apiUrl,
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'apiKey': apikey,
      'Authorization': 'Bearer ${MySharedPref.getToken}',
    },
  ),
);

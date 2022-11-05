import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';
import 'package:instagram_clone/app/models/user.dart';

import '../../config/translations/localization_service.dart';

class MySharedPref {
  // get storage
  static late final GetStorage _storage;

  // STORING KEYS
  static const String _currentLocalKey = 'current_local';
  static const String _userToken = 'user_token';
  static const String _searchHistory = 'search_suggestion';

  static const String _userId = 'user_id';
  static const String _name = 'user_name';
  static const String _nickName = 'user_nickName';
  static const String _email = 'user_email';
  static const String _phone = 'user_phone';
  static const String _dateOfBirth = 'user_dateOfBirth';
  static const String _image = 'user_image';

  /// init get storage services
  static init() async {
    await GetStorage.init();
    _storage = GetStorage();
  }

  static void setUserToken(String? userToken) => _storage.write(_userToken, userToken);

  /// takse a function that listens to changes to userToken
  static void userTokenListener(void Function(dynamic x) listener) =>
      _storage.listenKey(_userToken, listener);

  static String? get getToken => _storage.read(_userToken) == 'null' ? null : _storage.read(_userToken);

  /// save current locale
  static void setCurrentLanguage(String languageCode) => _storage.write(_currentLocalKey, languageCode);

  /// get current locale
  static Locale getCurrentLocal() {
    String? langCode = _storage.read(_currentLocalKey);
    // default language is english
    if (langCode == null) {
      return LocalizationService.defaultLanguage;
    }
    return LocalizationService.supportedLanguages[langCode]!;
  }

  //***************     User Data   ******************/

  static String? get getUserId => _storage.read(_userId);
  static void setUserId(String userId) => _storage.write(_userId, userId);

  static String? get getUserName => _storage.read(_name);
  static void setUserName(String userName) => _storage.write(_name, userName);

  static String? get getUserNickName => _storage.read(_nickName);
  static void setUserNickName(String nickName) => _storage.write(_nickName, nickName);

  static String? get getUserEmail => _storage.read(_email);
  static void setUserEmail(String userEmail) => _storage.write(_email, userEmail);

  static String? get getUserPhoneNumber => _storage.read(_phone);
  static void setUserPhoneNumber(String phoneNumber) => _storage.write(_phone, phoneNumber);

  static String? get getUserDateOfBirth => _storage.read(_dateOfBirth);
  static void setUserDateOfBirth(String dateOfBirth) => _storage.write(_dateOfBirth, dateOfBirth);

  static String? get getUserImage => _storage.read(_image);
  static void setUserImage(String? image) {
    if (image != null) {
      _storage.write(_image, image);
    }
  }

  static void setSearchHisotryList(List<String> searchHistory) =>
      _storage.write(_searchHistory, searchHistory);
  static List<String> get getRecentSearchs => (_storage.read(_searchHistory) ?? []).cast<String>();

  static void addSearch(String suggestion) {
    final List<String> suggestionsList = getRecentSearchs;

    /// if it exists in the search history
    if (suggestionsList.contains(suggestion)) {
      return;
    }
    suggestionsList.add(suggestion);
    setSearchHisotryList(suggestionsList);
  }

  static void removeSearch(String result) {
    final List<String> resultsList = getRecentSearchs;
    resultsList.removeWhere((e) => e == result);
    setSearchHisotryList(resultsList);
  }

  static User? get getUserData {
    final String? userId = MySharedPref.getUserId;

    if (userId == null) {
      log('there is no stored data about the user');
      return null;
    }
    final name = MySharedPref.getUserName;
    final nickName = MySharedPref.getUserNickName;
    final image = MySharedPref.getUserImage;

    return User(
      id: userId,
      userName: name!,
      nickName: nickName!,
      image: image,
      doIFollowHim: false,
      userStories: [],
    );
  }

  static void storeUserData({
    required String id,
    required String name,
    required String nickName,
    required String? image,
    required String email,
    required String phone,
    required String dateOfBirth,
  }) {
    MySharedPref.setUserId(id);
    MySharedPref.setUserName(name);
    MySharedPref.setUserNickName(nickName);
    MySharedPref.setUserImage(image);
    MySharedPref.setUserEmail(email);
    MySharedPref.setUserPhoneNumber(phone);
    MySharedPref.setUserDateOfBirth(dateOfBirth);
  }

  static void clearAllData() {
    _storage.erase();
  }
}

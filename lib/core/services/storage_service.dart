import 'package:instagram_clone/core/translations/localization_service.dart';

import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';
import 'package:instagram_clone/core/models/user.dart';


class StorageService {
  // get storage
  late final GetStorage _storage;

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
  Future<StorageService> init() async {
    await GetStorage.init();
    _storage = GetStorage();
    return this;
  }

  void setUserToken(String? userToken) =>
      _storage.write(_userToken, userToken);

  /// takse a function that listens to changes to userToken
  void userTokenListener(void Function(dynamic x) listener) =>
      _storage.listenKey(_userToken, listener);

  String? get getToken =>
      _storage.read(_userToken) == 'null' ? null : _storage.read(_userToken);

  /// save current locale
  void setCurrentLanguage(String languageCode) =>
      _storage.write(_currentLocalKey, languageCode);

  /// get current locale
  Locale getCurrentLocal() {
    String? langCode = _storage.read(_currentLocalKey);
    // default language is english
    if (langCode == null) {
      return LocalizationService.defaultLanguage;
    }
    return LocalizationService.supportedLanguages[langCode]!;
  }

  //***************     User Data   ******************/

  String? get getUserId => _storage.read(_userId);
  void setUserId(String userId) => _storage.write(_userId, userId);

  String? get getUserName => _storage.read(_name);
  void setUserName(String userName) => _storage.write(_name, userName);

  String? get getUserNickName => _storage.read(_nickName);
  void setUserNickName(String nickName) =>
      _storage.write(_nickName, nickName);

  String? get getUserEmail => _storage.read(_email);
  void setUserEmail(String userEmail) =>
      _storage.write(_email, userEmail);

  String? get getUserPhoneNumber => _storage.read(_phone);
  void setUserPhoneNumber(String phoneNumber) =>
      _storage.write(_phone, phoneNumber);

  String? get getUserDateOfBirth => _storage.read(_dateOfBirth);
  void setUserDateOfBirth(String dateOfBirth) =>
      _storage.write(_dateOfBirth, dateOfBirth);

  String? get getUserImage => _storage.read(_image);
  void setUserImage(String? image) {
    if (image != null) {
      _storage.write(_image, image);
    } else {
      _storage.remove(_image);
    }
  }

  void setSearchHisotryList(List<String> searchHistory) =>
      _storage.write(_searchHistory, searchHistory);
  List<String> get getRecentSearchs =>
      (_storage.read(_searchHistory) ?? []).cast<String>();

  void addSearch(String suggestion) {
    final List<String> suggestionsList = getRecentSearchs;

    /// if it exists in the search history
    if (suggestionsList.contains(suggestion)) {
      return;
    }
    suggestionsList.add(suggestion);
    setSearchHisotryList(suggestionsList);
  }

  void removeSearch(String result) {
    final List<String> resultsList = getRecentSearchs;
    resultsList.removeWhere((e) => e == result);
    setSearchHisotryList(resultsList);
  }

  User? get getUserData {
    final String? userId = getUserId;

    if (userId == null) {
      return null;
    }
    final name = getUserName;
    final nickName = getUserNickName;
    final image = getUserImage;

    return User(
      id: userId,
      userName: name!,
      nickName: nickName!,
      image: image,
      doIFollowHim: false,
      userStories: [],
    );
  }

  void storeUserData({
    required String id,
    required String name,
    required String nickName,
    required String? image,
    required String email,
    required String phone,
    required String dateOfBirth,
  }) {
    setUserId(id);
    setUserName(name);
    setUserNickName(nickName);
    setUserImage(image);
    setUserEmail(email);
    setUserPhoneNumber(phone);
    setUserDateOfBirth(dateOfBirth);
  }

  void clearAllData() {
    _storage.erase();
  }
}

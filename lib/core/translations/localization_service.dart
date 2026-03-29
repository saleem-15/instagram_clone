import 'package:instagram_clone/core/services/storage_service.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'ar_AR/ar_ar_translation.dart';
import 'en_US/en_us_translation.dart';

class LocalizationService extends Translations {
  // default language
  static Locale defaultLanguage = supportedLanguages['en']!;
  static Locale getCurrnetLanguage =
      Get.find<StorageService>().getCurrentLocal();

  // supported languages
  static Map<String, Locale> supportedLanguages = {
    'en': const Locale('en', 'US'),
    'ar': const Locale('ar', 'AR'),
  };

  // supported languages fonts family (must be in assets & pubspec yaml) or you can use google fonts
  static Map<String, TextStyle> supportedLanguagesFontsFamilies = {
    'en': const TextStyle(fontFamily: 'Poppins'),
    'ar': const TextStyle(fontFamily: 'Cairo'),
  };

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUs,
        'ar_AR': arAR,
      };

  /// check if the language is supported
  static bool isLanguageSupported(String languageCode) =>
      supportedLanguages.keys.contains(languageCode);

  /// update app language by code language for example (en,ar..etc)
  static Future<void> changeLanguage(String languageCode) async {
    assert(isLanguageSupported(languageCode), languageCode);

    // update current language in shared pref
    Get.find<StorageService>().setCurrentLanguage(languageCode);
    await Get.updateLocale(supportedLanguages[languageCode]!);
  }

  /// check if the language is english
  static bool isItEnglish() => Get.find<StorageService>()
      .getCurrentLocal()
      .languageCode
      .toLowerCase()
      .contains('en');

  /// get current locale
  static Locale getCurrentLocal() =>
      Get.find<StorageService>().getCurrentLocal();
}

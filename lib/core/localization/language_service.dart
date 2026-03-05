import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class LanguageService {
  static const String _languageKey = 'app_language';
  static const String _defaultLanguage = 'en';
  static const List<String> _supportedLanguages = ['en', 'ar'];

  final SharedPreferences _prefs;

  LanguageService(this._prefs);

  bool get hasLanguageSaved => _prefs.containsKey(_languageKey);

  String get deviceLanguageCode => PlatformDispatcher.instance.locale.languageCode;

  String get currentLanguage => _prefs.getString(_languageKey) ?? _defaultLanguage;

  Future<void> setLanguage(String language) async {
    await _prefs.setString(_languageKey, language);
  }

  bool isSupported(String code) => _supportedLanguages.contains(code);

  Future<void> resetToDefault() async {
    await _prefs.setString(_languageKey, _defaultLanguage);
  }
}

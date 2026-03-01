import 'package:shared_preferences/shared_preferences.dart';

class LanguageService {
  static const String _languageKey = 'app_language';
  static const String _defaultLanguage = 'en';

  final SharedPreferences _prefs;

  LanguageService(this._prefs);

  String get currentLanguage => _prefs.getString(_languageKey) ?? _defaultLanguage;

  Future<void> setLanguage(String language) async {
    await _prefs.setString(_languageKey, language);
  }

  Future<void> resetToDefault() async {
    await _prefs.setString(_languageKey, _defaultLanguage);
  }
}

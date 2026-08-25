import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  static const String _themeKey = 'app_theme_mode';

  final SharedPreferences _prefs;

  ThemeService(this._prefs);

  bool get hasThemeSaved => _prefs.containsKey(_themeKey);

  ThemeMode get currentThemeMode {
    final value = _prefs.getString(_themeKey);
    switch (value) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      case 'system':
        return ThemeMode.system;
      default:
        // No preference saved yet: follow the OS. The native splash window is
        // themed off the same OS flag (res/values-night), so this is the only
        // default that lets the splash and the first Flutter frame agree.
        return ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final value = switch (mode) {
      ThemeMode.dark => 'dark',
      ThemeMode.light => 'light',
      ThemeMode.system => 'system',
    };
    await _prefs.setString(_themeKey, value);
  }
}

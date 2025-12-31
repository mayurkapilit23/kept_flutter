import 'package:shared_preferences/shared_preferences.dart';

enum AppTheme { light, dark }

class ThemeRepository {
  static const _themeKey = 'app_theme';

  final SharedPreferences _prefs;

  ThemeRepository(this._prefs);

  Future<AppTheme> getTheme() async {
    final themeIndex = _prefs.getInt(_themeKey);

    // Default theme when app runs first time
    if (themeIndex == null || themeIndex >= AppTheme.values.length) {
      return AppTheme.light;
    }

    return AppTheme.values[themeIndex];
  }

  Future<void> saveTheme(AppTheme theme) async {
    await _prefs.setInt(_themeKey, theme.index);
  }
}
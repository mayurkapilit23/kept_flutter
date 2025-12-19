import 'package:shared_preferences/shared_preferences.dart';

enum AppTheme { light, dark }

class ThemeRepository {
  static const _themeKey = 'app_theme';

  Future<AppTheme> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(_themeKey);

    // Default theme when app runs first time
    if (themeIndex == null || themeIndex >= AppTheme.values.length) {
      return AppTheme.light;
    }

    return AppTheme.values[themeIndex];
  }

  Future<void> saveTheme(AppTheme theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, theme.index);
  }
}
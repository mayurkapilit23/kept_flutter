import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/login_response.dart';
import '../model/user.dart';

class AppSharedPreferences {
  static const _tokenKey = 'auth_token';
  static const _keyUser = 'auth_user';

  final SharedPreferences _prefs;

  AppSharedPreferences(this._prefs);

  //Token
  Future<void> saveToken(String token) async {
    await _prefs.setString(_tokenKey, token);
  }

  String? get token => _prefs.getString(_tokenKey);

  //User

  Future<void> saveUser(LoginResponse user) async {
    final userJson = jsonEncode(user.toJson());
    await _prefs.setString(_keyUser, userJson);
  }

  LoginResponse? getUser() {
    final userString = _prefs.getString(_keyUser);
    if (userString == null) return null;

    final Map<String, dynamic> json =
        jsonDecode(userString) as Map<String, dynamic>;

    return LoginResponse.fromJson(json);
  }

  Future<void> clearToken() async {
    await _prefs.remove(_tokenKey);
    await _prefs.remove(_keyUser);
  }

  bool get isLoggedIn => token != null;
}

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/login_response.dart';

class AppSharedPreferences {
  static const _tokenKey = 'auth_token';
  static const _keyUser = 'auth_user';

  // final SharedPreferences _prefs;

  // AppSharedPreferences(this._prefs);
  AppSharedPreferences();

  //Token
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // String? get token => prefs.getString(_tokenKey);

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(_tokenKey);
  }

  //User

  Future<void> saveUser(LoginResponse user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toJson());
    await prefs.setString(_keyUser, userJson);
  }

  Future<LoginResponse?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString(_keyUser);
    if (userString == null) return null;

    final Map<String, dynamic> json =
        jsonDecode(userString) as Map<String, dynamic>;

    return LoginResponse.fromJson(json);
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_tokenKey);
    await prefs.remove(_keyUser);
  }

  // bool get isLoggedIn => token != null;

  Future<bool> isLoggedIn() async {
    return await getToken() != null;
  }
}

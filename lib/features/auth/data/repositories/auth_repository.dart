import 'package:flutter/cupertino.dart';
import 'package:kept_flutter/features/auth/data/model/login_response.dart';
import 'package:kept_flutter/features/auth/data/repositories/app_shared_preferences.dart';
import 'package:kept_flutter/features/auth/data/services/auth_api_services.dart';

import '../model/user.dart';

class AuthRepository {
  final AuthApiServices service;

  final AppSharedPreferences prefs;

  AuthRepository(this.service, this.prefs);

  Future<Map<String, dynamic>> sendOtp(String phone) async {
    try {
      final data = await service.sendOtp(phone);

      debugPrint('Repo data => $data');

      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> verifyOtp({
    required String phone,
    required String otp,
    required String name,
  }) async {
    try {
      final loginResponse = await service.verifyOtp(
        phone: phone,
        otp: otp,
        name: name,
      );

      final token = loginResponse.token;

      if (token == null || token.isEmpty) {
        throw Exception('Invalid OTP or token missing');
      }

      //save token locally
      //save user locally
      await prefs.saveUser(loginResponse);

      //return user to Bloc
      return loginResponse.user;
      // return User.fromJson(loginResponse.user);
    } catch (e) {
      rethrow; // VERY IMPORTANT}
    }
  }

  Future<bool> isLoggedIn() async {
    return prefs.token != null;
  }

  LoginResponse? getCachedUser() {
    return prefs.getUser();
  }

  Future<void> logout() async {
    await prefs.clearToken();
  }
}

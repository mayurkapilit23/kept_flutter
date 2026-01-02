import 'dart:developer';

import 'package:kept_flutter/features/auth/data/model/login_response.dart';

import '../../../promise/data/services/dio_client.dart';

class AuthApiService {
  Future<Map<String, dynamic>> sendOtp(String phone) async {
    log('From AuthApiServices');
    final response = await DioClient.dio.post(
      '/auth/request-otp',
      data: {"phone": phone},
    );
    return response.data;
  }

  Future<LoginResponse> verifyOtp({
    required String phone,
    required String otp,
    required String name,
  }) async {
    final response = await DioClient.dio.post(
      '/auth/verify-otp',
      data: {"phone": phone, "otp": otp, "name": name},
    );

    return LoginResponse.fromJson(response.data); // raw JSON
  }
}

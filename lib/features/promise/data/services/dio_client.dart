import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:kept_flutter/core/utils/api_constants.dart';

import '../../../../core/utils/app_shared_preferences.dart';

class DioClient {
  static final Dio dio =
      Dio(
          BaseOptions(
            baseUrl: ApiConstants.baseUrl,
            headers: {'Content-Type': 'application/json'},
          ),
        )
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) async {
              final user = await AppSharedPreferences()
                  .getUser(); // sync or await if async
              log("TOKEN  ${user?.token}");
              if (user?.token != null && user!.token!.isNotEmpty) {
                options.headers['Authorization'] = 'Bearer ${user.token}';
              }

              return handler.next(options);
            },
          ),
        )
        ..interceptors.add(
          LogInterceptor(requestBody: true, responseBody: true),
        );
}

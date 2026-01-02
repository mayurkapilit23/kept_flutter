import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../auth/data/repositories/app_shared_preferences.dart';

class DioClient {
  static final Dio dio =
      Dio(
          BaseOptions(
            baseUrl: 'http://192.168.15.187:4000',
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

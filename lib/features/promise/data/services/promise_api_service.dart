import 'dart:developer';

import 'package:kept_flutter/features/promise/data/model/promise_response.dart';

import 'dio_client.dart';

class PromiseApiService {
  Future<PromiseResponse> createPromise({
    required String text,
    required String toPhone,
    required String toName,
    required String dueAt,
  }) async {

    log('From AuthApiServices');
    final response = await DioClient.dio.post(
      '/promises',
      data: {
        "text": text,
        "toPhone": toPhone,
        "toName": toName,
        "dueAt": dueAt,
      },
    );
    return PromiseResponse.fromJson(response.data);
  }
}

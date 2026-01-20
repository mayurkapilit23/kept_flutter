import 'dart:convert';
import 'dart:developer';

import 'package:kept_flutter/core/utils/api_constants.dart';
import 'package:kept_flutter/features/promise/data/model/promise_response.dart';

import '../../../../core/helperMethods/helper_method.dart';
import '../model/recent_response_model.dart';
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
      ApiConstants.createPromise,
      data: {
        "text": text,
        "toPhone": toPhone,
        "toName": toName,
        "dueAt": dueAt,
      },
    );
    return PromiseResponse.fromJson(response.data);
  }

  Future<List<Promise>> fetchPromises() async {
    try {
      final response = await DioClient.dio.get(ApiConstants.getPromises);
      final List data = response.data['promises'];
      showLog("Api Response", data);
      return data.map((e) => Promise.fromJson(e)).toList();
    } catch (e) {
      showLog("Api Error", e.toString());
      throw Exception('Failed to fetch promises : $e');
    }
  }

  Future<RecentContactResponse> getRecentContact() async {
    try {
      final response = await DioClient.dio.get(ApiConstants.getRecentContacts);
      // final List data = response.data['promises'];
      // showLog("Api Response", data);
      // return RecentContactResponse.fromJson(response.data);
      final data = response.data is String
          ? jsonDecode(response.data)
          : response.data;
      return RecentContactResponse.fromJson(data);
    } catch (e) {
      showLog("Api Error", e.toString());
      throw Exception('Failed to fetch recent contacts: $e');
    }
  }
}

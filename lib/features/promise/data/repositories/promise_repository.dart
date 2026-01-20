import 'package:kept_flutter/features/promise/data/model/promise_response.dart';
import 'package:kept_flutter/features/promise/data/services/promise_api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/recent_response_model.dart';

class PromiseRepository {
  static const _contactsLoadedKey = 'contacts_loaded';
  final SharedPreferences _prefs;
  final _promiseApiService = PromiseApiService();

  PromiseRepository(this._prefs);

  Future<PromiseResponse> createPromise({
    required String text,
    required String toPhone,
    required String toName,
    required String dueAt,
  }) async {
    try {
      final promiseResponse = await _promiseApiService.createPromise(
        text: text,
        toPhone: toPhone,
        toName: toName,
        dueAt: dueAt,
      );
      //return user to Bloc
      return promiseResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setContactsLoaded(bool value) async {
    await _prefs.setBool(_contactsLoadedKey, value);
  }

  Future<bool> isContactsLoaded() async {
    return _prefs.getBool(_contactsLoadedKey) ?? false;
  }

  Future<List<Promise>> getPromises() {
    return _promiseApiService.fetchPromises();
  }

  Future<RecentContactResponse> getRecentContact() {
    return _promiseApiService.getRecentContact();
  }
}

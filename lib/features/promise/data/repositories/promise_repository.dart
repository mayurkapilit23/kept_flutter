import 'package:kept_flutter/features/promise/data/model/promise_response.dart';
import 'package:kept_flutter/features/promise/data/services/promise_api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PromiseRepository {
  static const _contactsLoadedKey = 'contacts_loaded';
  final SharedPreferences _prefs;
  final _service = PromiseApiService();

  PromiseRepository(this._prefs);

  Future<PromiseResponse> createPromise({
    required String text,
    required String toPhone,
    required String toName,
    required String dueAt,
  }) async {
    try {
      final promiseResponse = await _service.createPromise(
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
}

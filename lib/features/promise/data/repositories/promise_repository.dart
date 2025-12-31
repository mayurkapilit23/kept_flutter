import 'package:shared_preferences/shared_preferences.dart';

class PromiseRepository {
  static const _contactsLoadedKey = 'contacts_loaded';
  final SharedPreferences _prefs;

  PromiseRepository(this._prefs);

  Future<void> setContactsLoaded(bool value) async {
    await _prefs.setBool(_contactsLoadedKey, value);
  }

  Future<bool> isContactsLoaded() async {
    return _prefs.getBool(_contactsLoadedKey) ?? false;
  }
}

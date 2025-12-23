import 'package:shared_preferences/shared_preferences.dart';

class PromiseRepository {
  static const _contactsLoadedKey = 'contacts_loaded';

  Future<void> setContactsLoaded(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_contactsLoadedKey, value);
  }

  Future<bool> isContactsLoaded() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_contactsLoadedKey) ?? false;
  }
}

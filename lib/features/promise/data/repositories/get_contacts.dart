import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

Future<List<Contact>> getContacts() async {
  final permissionGranted = await FlutterContacts.requestPermission(
    readonly: true,
  );

  if (!permissionGranted) {
    debugPrint('❌ Contacts permission denied');
    return [];
  }

  final contacts = await FlutterContacts.getContacts(
    withProperties: true,
    withPhoto: false,
  );

  debugPrint('✅ Contacts count: ${contacts.length}');
  return contacts;
}

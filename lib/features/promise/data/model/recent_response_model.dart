import 'package:flutter_contacts/contact.dart';

class ApiContact {
  final String name;
  final String phone;

  ApiContact({required this.name, required this.phone});

  factory ApiContact.fromJson(Map<String, dynamic> json) {
    return ApiContact(name: json['name'] ?? '', phone: json['phone'] ?? '');
  }
}

class RecentContactResponse {
  final List<ApiContact> contacts;

  RecentContactResponse({required this.contacts});

  factory RecentContactResponse.fromJson(Map<String, dynamic> json) {
    final list = json['contacts'] as List<dynamic>? ?? [];
    return RecentContactResponse(
      contacts: list.map((e) => ApiContact.fromJson(e)).toList(),
    );
  }
}

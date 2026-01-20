import 'dart:core';

class ApiConstants {
  ApiConstants._();

  static String baseUrl = "http://192.168.15.187:4000";
  // static String requestOtp = "$baseUrl/auth/request-otp";
  static String requestOtp = "/auth/request-otp";
  // static String verifyOtp = "$baseUrl/auth/verify-otp";
  static String verifyOtp = "/auth/verify-otp";
  // static String createPromise = "$baseUrl/promises";
  static String createPromise = "/promises";
  // static String getPromises = "$baseUrl/promises/my";
  static String getPromises = "/promises/my";
  // static String getRecentContacts = "$baseUrl/contacts/recent";
  static String getRecentContacts = "/contacts/recent";
  //temp
  static String markAsDone =
      "$baseUrl/promises/2b245129-5da1-4a9c-bc28-2eee73495705/done";
}

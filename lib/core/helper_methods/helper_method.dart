import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension ThemeBrightnessX on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  bool get isLight => !isDark;
}

class HelperMethods {
  static String formatDate(DateTime date) => DateFormat('MMM d').format(date);

  static String formatTime(DateTime date) => DateFormat('h:mm a').format(date);

}

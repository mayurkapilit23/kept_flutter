import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension ThemeBrightnessX on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  bool get isLight => !isDark;
}

class HelperMethods {
  static String formatDate(DateTime date) => DateFormat('MMM d').format(date);

  static String formatTime(DateTime date) {
    final dateWithDefaultTime = DateTime(
      date.year,
      date.month,
      date.day,
      18, // 6 PM
      0, // minutes
    );

    return DateFormat('h:mm a').format(dateWithDefaultTime);
  }
  static String tomorrowAtSixPM() {
    final now = DateTime.now();
    final tomorrow = now.add(const Duration(days: 1));

    final dateTime = DateTime(
      tomorrow.year,
      tomorrow.month,
      tomorrow.day,
      18, // 6 PM
      0,
    );

    return 'Tomorrow by ${DateFormat('h a').format(dateTime)}';
  }
  /// Forces time to 6:00 PM for any selected date
  static DateTime normalizeToSixPM(DateTime selectedDate) {
    return DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      18, // 6 PM
      0,
    );
  }
  static String displayDate(DateTime date) {
    return DateFormat('MMM d, h a').format(date);
  }


  static String formateDateDB(DateTime dateTime) =>
      dateTime.toUtc().toIso8601String();
}

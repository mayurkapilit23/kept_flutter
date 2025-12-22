import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension ThemeBrightnessX on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  bool get isLight => !isDark;
}

class HelperMethods {
  static String formatDate(DateTime date) => DateFormat('MMM d').format(date);

  static String formatTime(DateTime date) => DateFormat('h:mm a').format(date);

  static OverlayEntry? _overlayEntry;

  static void showOverlay(BuildContext context, Widget child) {
    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Optional dark background
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                _overlayEntry?.remove();
                _overlayEntry = null;
              },
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),
          ),

          // Overlay content
          Center(
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 250),
              tween: Tween(begin: 0, end: 1),
              curve: Curves.easeOutCubic,
              builder: (_, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.scale(
                    scale: 0.95 + (0.05 * value),
                    child: child,
                  ),
                );
              },
              child: Material(color: Colors.transparent, child: child),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }
}

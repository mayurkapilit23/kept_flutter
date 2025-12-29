import 'package:flutter/material.dart';

class OverlayController {
  static OverlayEntry? _entry;
  static bool _isOpen = false;

  /// Show overlay only if not already open
  static void show({
    required BuildContext context,
    required Widget child,
    bool dismissOnTapOutside = true,
    VoidCallback? onDismiss,
  }) {
    if (_isOpen) return; // ✅ prevent duplicates

    _entry = OverlayEntry(
      builder: (_) => Stack(
        children: [
          // Dark background
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (){
                close();
                onDismiss?.call();
              },
              child: Container(
                color: Colors.black.withOpacity(0.35),
              ),
            ),
          ),

          // Overlay content
          Center(
            child: _AnimatedOverlay(child: child),
          ),
        ],
      ),
    );

    Overlay.of(context, rootOverlay: true).insert(_entry!);
    _isOpen = true;
  }

  /// Close overlay safely
  static void close() {
    if (!_isOpen) return;

    _entry?.remove();
    _entry = null;
    _isOpen = false;
  }

  /// Use this in back button / PopScope
  static bool closeIfOpen() {
    if (_isOpen) {
      close();
      return true; // ⛔ stop navigation
    }
    return false;
  }

  /// Optional helper
  static bool get isOpen => _isOpen;
}

/// Private animated wrapper
class _AnimatedOverlay extends StatelessWidget {
  final Widget child;

  const _AnimatedOverlay({required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
      tween: Tween(begin: 0, end: 1),
      builder: (_, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(
            scale: 0.95 + (0.05 * value),
            child: child,
          ),
        );
      },
      child: Material(
        color: Colors.transparent,
        child: child,
      ),
    );
  }
}

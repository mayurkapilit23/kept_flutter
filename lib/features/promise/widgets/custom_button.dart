import 'package:flutter/material.dart';

import '../../../core/colors/app_colors.dart';

enum ButtonHeight { small, medium, large }

enum ButtonWidth {
  auto, // wraps content
  full, // double.infinity
  fixed, // percentage based
}

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final ButtonHeight height;
  final ButtonWidth width;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.title,
    this.onPressed,
    this.height = ButtonHeight.medium,
    this.width = ButtonWidth.full,
    this.isLoading = false,
  });

  double _height(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    switch (height) {
      case ButtonHeight.small:
        return h * 0.045;
      case ButtonHeight.medium:
        return h * 0.06;
      case ButtonHeight.large:
        return h * 0.07;
    }
  }

  double? _width(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    switch (width) {
      case ButtonWidth.auto:
        return null;
      case ButtonWidth.full:
        return double.infinity;
      case ButtonWidth.fixed:
        return w * 0.5; // 50% of screen
    }
  }

  double _fontSize(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    switch (height) {
      case ButtonHeight.small:
        return h * 0.015;
      case ButtonHeight.medium:
        return h * 0.018;
      case ButtonHeight.large:
        return h * 0.02;
    }
  }

  EdgeInsets _padding() {
    if (width == ButtonWidth.auto) {
      return const EdgeInsets.symmetric(horizontal: 16);
    }
    return EdgeInsets.zero;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      width: _width(context),
      height: _height(context),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isDark
              ? AppColors.lightSecondary
              : AppColors.darkPrimary,
          foregroundColor: isDark ? Colors.black : Colors.white,
          padding: _padding(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: _fontSize(context),
                ),
              ),
      ),
    );
  }
}

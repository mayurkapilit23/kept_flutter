import 'package:flutter/material.dart';
import 'package:kept_flutter/core/colors/app_colors.dart';
import 'package:kept_flutter/core/helper_methods/helper_method.dart';

class CustomSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool autofocus;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefix;
  final Widget? suffix;
  final int maxLines;
  final ValueChanged<String>? onChanged;

  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.hintText,
    this.autofocus = false,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefix,
    this.suffix,
    this.maxLines = 1,
    this.onChanged,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    // final isDark = Theme.of(context).brightness == Brightness.dark;

    return Focus(
      onFocusChange: (focus) => setState(() => _focused = focus),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        decoration: BoxDecoration(
          color: context.isDark
              ? AppColors.darkSecondary
              : AppColors.lightPrimary,

          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _focused
                ? context.isDark
                      ? AppColors.lightPrimary
                      : AppColors.darkSecondary
                : context.isDark
                ? Colors.grey
                : Colors.grey,

            width: 1,
          ),
        ),
        child: TextField(
          controller: widget.controller,
          autofocus: widget.autofocus,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
          maxLines: widget.maxLines,
          onChanged: widget.onChanged,
          style: TextStyle(
            fontSize: 14,
            color: context.isDark ? Colors.white : Colors.black,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: context.isDark
                  ? Colors.white.withOpacity(0.4)
                  : Colors.black.withOpacity(0.4),
            ),
            prefixIcon: widget.prefix,
            suffixIcon: widget.suffix,
          ),
        ),
      ),
    );
  }
}

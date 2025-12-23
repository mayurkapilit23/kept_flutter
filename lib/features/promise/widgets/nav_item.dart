import 'package:flutter/material.dart';
import 'package:kept_flutter/core/helper_methods/helper_method.dart';

import '../../../core/colors/app_colors.dart';

class NavItem extends StatelessWidget {
  final IconData icon;
  final int index;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const NavItem({
    super.key,
    required this.icon,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = index == currentIndex;

    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: context.isDark
              ? isSelected
                    ? AppColors.lightPrimary.withOpacity(0.15)
                    : Colors.transparent
              : isSelected
              ? AppColors.darkSecondary.withOpacity(0.15)
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 30,
          color: context.isDark
              ? isSelected
                    ? AppColors.lightSecondary
                    : Colors.grey
              : isSelected
              ? AppColors.darkPrimary
              : Colors.grey,
        ),
      ),
    );
  }
}

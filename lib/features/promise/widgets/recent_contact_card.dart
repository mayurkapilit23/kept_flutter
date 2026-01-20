import 'package:flutter/material.dart';
import 'package:kept_flutter/core/helperMethods/helper_method.dart';

import '../../../core/colors/app_colors.dart';

class RecentContactCard extends StatelessWidget {
  final String name;
  final String phone;
  final VoidCallback? onTap;

  const RecentContactCard({
    super.key,
    required this.name,
    required this.phone,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 180,
          maxWidth: 260, // adapts on tablets
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: isDark
              ? Colors.white.withOpacity(0.08)
              : Colors.black.withOpacity(0.05),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min, // auto height
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: isDark
                      ? AppColors.lightSecondary
                      : AppColors.darkPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                phone.trim(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

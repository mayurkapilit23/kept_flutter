import 'package:flutter/material.dart';
import 'package:kept_flutter/core/helper_methods/helper_method.dart';

import '../../../core/colors/app_colors.dart';

class PromiseCard extends StatelessWidget {
  final bool pending;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const PromiseCard({
    super.key,
    required this.pending,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: context.isDark
            ? AppColors.darkSecondary
            : AppColors.lightSecondary,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(16),

            child: Row(
              children: [
                // Text section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: context.isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                // Status Icon
                Icon(
                  pending ? Icons.circle_outlined : Icons.check_circle,
                  color: pending ? Colors.orange : Colors.green,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

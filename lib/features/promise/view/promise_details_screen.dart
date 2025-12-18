import 'package:flutter/material.dart';

import '../../../core/colors/app_colors.dart';
import '../widgets/custom_button.dart';

class PromiseDetailsScreen extends StatelessWidget {
  const PromiseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPrimary,

      appBar: AppBar(backgroundColor: AppColors.lightPrimary),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Send ₹5,000', style: TextStyle(fontSize: 28)),
            const SizedBox(height: 12),
            const Text('To Ramesh'),
            const Text('Today · 6:00 PM', style: TextStyle(color: Colors.grey)),
            const Spacer(),

            AppPrimaryButton(
              title: 'Mark as Done',
              height: ButtonHeight.medium,
              width: ButtonWidth.full,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

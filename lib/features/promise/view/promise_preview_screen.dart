import 'package:flutter/material.dart';

import '../../../core/colors/app_colors.dart';
import '../widgets/custom_button.dart';

class PromisePreviewScreen extends StatelessWidget {
  const PromisePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPrimary,

      appBar: AppBar(backgroundColor: AppColors.lightPrimary),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.whiteColor,
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Send ₹5,000', style: TextStyle(fontSize: 28)),
                  const SizedBox(height: 12),
                  const Text('To Ramesh'),
                  const Text(
                    'Today · 6:00 PM',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 50),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AppPrimaryButton(
                        title: 'Mark as Done',
                        height: ButtonHeight.medium,
                        width: ButtonWidth.auto,
                        onPressed: () {},
                      ),
                      AppPrimaryButton(
                        title: 'Mark as Done',
                        height: ButtonHeight.medium,
                        width: ButtonWidth.auto,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

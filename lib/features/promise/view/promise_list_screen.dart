import 'package:flutter/material.dart';
import 'package:kept_flutter/core/helper_methods/app_route.dart';
import 'package:kept_flutter/core/helper_methods/helper_method.dart';
import 'package:kept_flutter/features/promise/view/promise_details_screen.dart';

import '../../../core/colors/app_colors.dart';
import '../widgets/promise_card.dart';

class PromiseListScreen extends StatefulWidget {
  const PromiseListScreen({super.key});

  @override
  State<PromiseListScreen> createState() => _PromiseListScreenState();
}

class _PromiseListScreenState extends State<PromiseListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.isDark
          ? AppColors.darkPrimary
          : AppColors.lightPrimary,

      appBar: AppBar(
        automaticallyImplyLeading: false,

        backgroundColor: context.isDark
            ? AppColors.darkPrimary
            : AppColors.lightPrimary,

        title: const Text('Promises'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          PromiseCard(
            pending: true,
            title: 'Send ₹5,000',
            subtitle: 'Ramesh · Today 6:00 PM',
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => PromiseDetailsScreen()),
              // );
              navigateTo(context, PromiseDetailsScreen());
              // Navigator.push(context, AppRoute.smooth(PromiseDetailsScreen()));
            },
          ),
          PromiseCard(
            pending: false,
            title: 'Send ₹5,000',
            subtitle: 'Ramesh · Today 6:00 PM',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

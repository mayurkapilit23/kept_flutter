import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kept_flutter/core/helper_methods/helper_method.dart';
import 'package:kept_flutter/features/promise/view/promise_input_screen.dart';
import 'package:kept_flutter/features/promise/view/promise_list_screen.dart';

import '../../../core/colors/app_colors.dart';
import '../widgets/nav_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _screens = const [
    PromiseInputScreen(),
    PromiseListScreen(),
    // PromiseDetailsScreen(),
  ];

  void _onTap(int index) {
    HapticFeedback.selectionClick();
    setState(() => _currentIndex = index);
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.isDark
          ? AppColors.darkPrimary
          : AppColors.lightPrimary,
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 10),
          child: Container(
            height: 54,
            width: MediaQuery.of(context).size.width * 0.50,
            decoration: BoxDecoration(
              color: context.isDark
                  ? AppColors.darkSecondary
                  : AppColors.lightSecondary,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(0.12),
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NavItem(
                  icon: Icons.home,
                  index: 0,
                  currentIndex: _currentIndex,
                  onTap: _onTap,
                ),
                NavItem(
                  icon: Icons.list,
                  index: 1,
                  currentIndex: _currentIndex,
                  onTap: _onTap,
                ),
                // NavItem(
                //   icon: Icons.settings,
                //   index: 2,
                //   currentIndex: _currentIndex,
                //   onTap: _onTap,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

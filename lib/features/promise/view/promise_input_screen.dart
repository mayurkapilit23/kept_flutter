import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kept_flutter/core/helper_methods/helper_method.dart';
import 'package:kept_flutter/features/promise/view/select_person_screen.dart';
import 'package:kept_flutter/features/promise/widgets/custom_button.dart';
import 'package:lottie/lottie.dart';

import '../../../core/colors/app_colors.dart';
import '../../theme/bloc/theme_bloc.dart';
import '../../theme/bloc/theme_event.dart';
import '../../theme/data/repositories/theme_repository.dart';

class PromiseInputScreen extends StatefulWidget {
  const PromiseInputScreen({super.key});

  @override
  State<PromiseInputScreen> createState() => _PromiseInputScreenState();
}

class _PromiseInputScreenState extends State<PromiseInputScreen> {
  final controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // Delay focus until UI is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: context.isDark
          ? AppColors.darkPrimary
          : AppColors.lightPrimary,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: context.isDark
            ? AppColors.darkPrimary
            : AppColors.lightPrimary,
        actions: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: IconButton(
              key: ValueKey(context.watch<ThemeBloc>().state.theme),
              onPressed: () {
                final isDark =
                    context.read<ThemeBloc>().state.theme == AppTheme.dark;

                context.read<ThemeBloc>().add(
                  ToggleTheme(isDark ? AppTheme.light : AppTheme.dark),
                );
              },
              icon: Icon(
                context.watch<ThemeBloc>().state.theme == AppTheme.dark
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Animation
                        Center(
                          child: Lottie.asset(
                            'assets/Assignees.json',
                            height: constraints.maxHeight * 0.50,
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Input
                        TextField(
                          controller: controller,
                          // autofocus: true,
                          focusNode: _focusNode,
                          decoration: InputDecoration(
                            hintText: 'What did you promise?',
                            hintStyle: TextStyle(
                              color: context.isDark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(fontSize: 26),
                        ),

                        const SizedBox(height: 16),

                        const Text(
                          'Examples: Send ₹5,000 · Call mom · Share documents',
                          style: TextStyle(color: Colors.grey),
                        ),

                        const Spacer(),

                        //  Bottom Button
                        Align(
                          alignment: Alignment.centerRight,
                          child: AppPrimaryButton(
                            title: 'Next',
                            height: ButtonHeight.medium,
                            width: ButtonWidth.fixed,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SelectPersonScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

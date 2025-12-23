import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kept_flutter/core/helper_methods/app_route.dart';
import 'package:kept_flutter/core/helper_methods/helper_method.dart';
import 'package:kept_flutter/features/promise/bloc/promise_bloc.dart';
import 'package:kept_flutter/features/promise/bloc/promise_event.dart';
import 'package:kept_flutter/features/promise/bloc/promise_state.dart';
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
            duration: const Duration(milliseconds: 150),
            child: IconButton(
              key: ValueKey(context.isDark),
              onPressed: () {
                HapticFeedback.selectionClick();
                context.read<ThemeBloc>().add(
                  ToggleTheme(context.isDark ? AppTheme.light : AppTheme.dark),
                );
              },
              icon: Icon(context.isDark ? Icons.light_mode : Icons.dark_mode),
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
                    child: BlocConsumer<PromiseBloc, PromiseState>(
                      listener: (context, state) {
                        // if (state is PromiseError) {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(content: Text(state.message)),
                        //   );
                        // }

                        if (state is NavigateToSelectPromiseScreen) {
                          navigateTo(context, SelectPersonScreen());
                        }
                      },
                      builder: (context, state) {
                        return Column(
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
                                  fontWeight: FontWeight.normal,
                                  color: context.isDark
                                      ? Colors.grey
                                      : Colors.grey,
                                ),
                                border: InputBorder.none,
                              ),
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w900,
                              ),
                            ),

                            const SizedBox(height: 16),

                            const Text(
                              'e.g. Send ₹5,000 · Call mom · Share documents',
                              style: TextStyle(color: Colors.grey),
                            ),

                            const Spacer(),

                            //  Bottom Button
                            Align(
                              alignment: Alignment.centerRight,
                              child: ValueListenableBuilder(
                                valueListenable: controller,
                                builder: (context, value, child) {
                                  return CustomButton(
                                    title: 'Next',
                                    height: ButtonHeight.medium,
                                    width: ButtonWidth.fixed,
                                    onPressed: controller.text.trim().isEmpty
                                        ? null
                                        : () async {
                                            context.read<PromiseBloc>().add(
                                              SetPromiseText(
                                                controller.text
                                                    .toString()
                                                    .trim(),
                                              ),
                                            );

                                            // Navigator.push(
                                            //   context,
                                            //   AppRoute.smooth(
                                            //     const SelectPersonScreen(),
                                            //   ),
                                            // );
                                          },
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
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

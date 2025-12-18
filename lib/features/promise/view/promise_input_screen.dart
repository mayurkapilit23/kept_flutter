import 'package:flutter/material.dart';
import 'package:kept_flutter/features/promise/view/select_person_screen.dart';
import 'package:kept_flutter/features/promise/widgets/custom_button.dart';
import 'package:lottie/lottie.dart';

import '../../../core/colors/app_colors.dart';

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

    // 👇 Delay focus until UI is built
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
      backgroundColor: AppColors.lightPrimary,
      // resizeToAvoidBottomInset: true,
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
                          decoration: const InputDecoration(
                            hintText: 'What did you promise?',
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
                                  builder: (_) => const SelectPersonScreen(),
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

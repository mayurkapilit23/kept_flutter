import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kept_flutter/core/helper_methods/helper_method.dart';
import 'package:kept_flutter/features/promise/bloc/promise_bloc.dart';
import 'package:kept_flutter/features/promise/bloc/promise_state.dart';

import '../../../core/colors/app_colors.dart';
import '../widgets/custom_button.dart';

class PromisePreviewScreen extends StatelessWidget {
  const PromisePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.isDark
          ? AppColors.darkPrimary
          : AppColors.lightPrimary,

      appBar: AppBar(
        backgroundColor: context.isDark
            ? AppColors.darkPrimary
            : AppColors.lightPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: BlocConsumer<PromiseBloc, PromiseState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is! PromiseLoaded) {
              return const SizedBox();
            }
            final p = state.promise;
            print('Promise Text ${p.text}');
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: context.isDark
                        ? AppColors.darkSecondary
                        : AppColors.lightSecondary,
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p.text,
                        style: TextStyle(
                          fontSize: 28,
                          // color: context.isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text('To ${p.toName}'),
                      Text(
                        '${HelperMethods.formatDate(p.createdAt)} · ${HelperMethods.formatTime(p.createdAt)}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 50),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomButton(
                            title: 'Mark as Done',
                            height: ButtonHeight.medium,
                            width: ButtonWidth.auto,
                            onPressed: () {
                              HapticFeedback.lightImpact();
                            },
                          ),
                          CustomButton(
                            title: 'Set Reminder',
                            height: ButtonHeight.medium,
                            width: ButtonWidth.auto,
                            onPressed: () {
                              HapticFeedback.lightImpact();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

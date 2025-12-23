import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kept_flutter/core/helper_methods/helper_method.dart';
import 'package:kept_flutter/features/promise/bloc/promise_bloc.dart';
import 'package:kept_flutter/features/promise/bloc/promise_state.dart';

import '../../../core/colors/app_colors.dart';
import '../widgets/custom_button.dart';

class PromisePreviewCard extends StatelessWidget {
  const PromisePreviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PromiseBloc, PromiseState>(
      builder: (context, state) {
        if (state is! PromiseLoaded) {
          return const SizedBox();
        }

        final p = state.promise;

        return Material(
          color: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            constraints: const BoxConstraints(maxWidth: 420),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: context.isDark
                  ? AppColors.darkSecondary
                  : AppColors.lightSecondary,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(0.15),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Promise text
                Text(
                  p.text,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: context.isDark ? Colors.white : Colors.black,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  'To 🧑${p.toName}',
                  style: TextStyle(
                    fontSize: 16,
                    color: context.isDark ? Colors.white70 : Colors.black87,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  '${HelperMethods.formatDate(p.createdAt)} · ${HelperMethods.formatTime(p.createdAt)}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 6),
                Text(
                  'Reminder: Today (default)',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ChoiceChip(
                    //   label: const Text("Tomorrow"),
                    //   selected: false,
                    //   onSelected: (_) {},
                    // ),
                    // ChoiceChip(
                    //   label: const Text("Set Reminder"),
                    //   selected: false,
                    //   onSelected: (_) {},
                    // ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                    CustomButton(
                      title: 'Send',
                      height: ButtonHeight.small,
                      width: ButtonWidth.auto,
                      onPressed: () {
                        HapticFeedback.lightImpact();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 6),
              ],
            ),
          ),
        );
      },
    );
  }
}

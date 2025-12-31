import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kept_flutter/core/helper_methods/helper_method.dart';
import 'package:kept_flutter/features/promise/bloc/promise_bloc.dart';
import 'package:kept_flutter/features/promise/bloc/promise_event.dart';
import 'package:kept_flutter/features/promise/bloc/promise_state.dart';
import 'package:kept_flutter/features/promise/view/home_screen.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../core/colors/app_colors.dart';
import '../widgets/custom_button.dart';

class PromisePreviewScreen extends StatefulWidget {
  const PromisePreviewScreen({super.key});

  @override
  State<PromisePreviewScreen> createState() => _PromisePreviewScreenState();
}

class _PromisePreviewScreenState extends State<PromisePreviewScreen> {
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
          listener: (context, state) {},
          builder: (context, state) {
            if (state is! PromiseLoaded) {
              return const SizedBox();
            }
            final promise = context.read<PromiseBloc>().promiseModel;
            // final p = state.promise;

            print('Promise Text ${promise.dueAt}');
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
                        promise.text.toString(),
                        style: TextStyle(
                          fontSize: 28,
                          // color: context.isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text('To ${promise.toName.toString()}'),
                      Text(
                        // '${HelperMethods.formatDate(p.createdAt)} · ${HelperMethods.formatTime(p.createdAt)}',
                        '${HelperMethods.formatDate(promise.dueAt ?? DateTime.now())} · 6:00 PM (Default Time)',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 50),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton(
                            title: 'Change Date',
                            height: ButtonHeight.medium,
                            width: ButtonWidth.auto,
                            onPressed: () {
                              HapticFeedback.lightImpact();
                              showDatePickerDialog(context);
                            },
                          ),
                          CustomButton(
                            title: 'Ok',
                            height: ButtonHeight.medium,
                            width: ButtonWidth.auto,
                            onPressed: () {
                              HapticFeedback.lightImpact();
                              context.read<PromiseBloc>().promiseModel.text =
                                  "";

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                                (d) => false,
                              );
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

Future<void> showDatePickerDialog(BuildContext context) async {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: context.isDark
          ? AppColors.darkSecondary
          : AppColors.lightPrimary,
      content: SizedBox(
        height: 350,
        width: 300,
        child: SfDateRangePicker(
          enablePastDates: false,

          monthCellStyle: DateRangePickerMonthCellStyle(
            disabledDatesTextStyle: TextStyle(color: Colors.grey),
            blackoutDateTextStyle: TextStyle(color: Colors.red),
            todayTextStyle: TextStyle(
              color: context.isDark
                  ? AppColors.lightSecondary
                  : AppColors.darkPrimary,
              // fontWeight: FontWeight.bold,
            ),
          ),
          headerStyle: DateRangePickerHeaderStyle(
            textStyle: TextStyle(
              color: context.isDark
                  ? AppColors.lightSecondary
                  : AppColors.darkPrimary,
            ),
            backgroundColor: context.isDark
                ? AppColors.darkSecondary
                : AppColors.lightPrimary,
          ),
          todayHighlightColor: context.isDark
              ? AppColors.lightSecondary
              : AppColors.darkPrimary,
          selectionColor: Colors.blue,
          startRangeSelectionColor: Colors.green,
          endRangeSelectionColor: Colors.red,
          rangeSelectionColor: Colors.blue.withOpacity(0.2),

          // selectionColor: context.isDark
          //     ? AppColors.darkSecondary
          //     : AppColors.lightPrimary,
          backgroundColor: context.isDark
              ? AppColors.darkSecondary
              : AppColors.lightPrimary,
          selectionMode: DateRangePickerSelectionMode.single,
          showActionButtons: true,
          onSubmit: (value) {
            final DateTime? selectedDate = value as DateTime?;
            context.read<PromiseBloc>().promiseModel.dueAt = selectedDate;
            if (selectedDate != null) {
              context.read<PromiseBloc>().add(SetDueDate(selectedDate));
            }
            Navigator.pop(context);
          },
          // onSelectionChanged: (args) {
          //   final DateTime selectedDate = args.value;
          //   print(selectedDate);
          //   Navigator.pop(context);
          // },
          onCancel: () => Navigator.pop(context),
        ),
      ),
    ),
  );
}

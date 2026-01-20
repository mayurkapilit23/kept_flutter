import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kept_flutter/core/helperMethods/helper_method.dart';
import 'package:kept_flutter/features/promise/bloc/promise_bloc.dart';
import 'package:kept_flutter/features/promise/bloc/promise_event.dart';
import 'package:kept_flutter/features/promise/views/promise_details_screen.dart';

import '../../../core/colors/app_colors.dart';
import '../bloc/promise_state.dart';
import '../widgets/promise_card.dart';

class PromiseListScreen extends StatefulWidget {
  const PromiseListScreen({super.key});

  @override
  State<PromiseListScreen> createState() => _PromiseListScreenState();
}

class _PromiseListScreenState extends State<PromiseListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PromiseBloc>().add(FetchPromises());
  }

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
      body: BlocBuilder<PromiseBloc, PromiseState>(
        builder: (context, state) {
          // Loading
          if (state is PromiseLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error
          if (state is PromiseError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          // Success → LIST
          if (state is PromiseListLoaded) {
            final promises = state.promises;

            if (promises!.isEmpty) {
              return const Center(child: Text('No promises found'));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: promises.length,
              itemBuilder: (context, index) {
                final promise = promises[index];

                return PromiseCard(
                  pending: promise.status == 'pending',
                  title: promise.text ?? '',
                  subtitle:
                      '${promise.toPhone ?? ''} · ${HelperMethods.formatDate(promise.dueAt)}',
                  // subtitle: '${promise.toPhone ?? ''} · ',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PromiseDetailsScreen(promise: promise),
                      ),
                    );
                  },
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

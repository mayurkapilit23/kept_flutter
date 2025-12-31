import 'dart:core';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kept_flutter/core/helper_methods/app_route.dart';
import 'package:kept_flutter/core/helper_methods/helper_method.dart';
import 'package:kept_flutter/features/promise/bloc/promise_state.dart';
import 'package:kept_flutter/features/promise/view/promise_preview_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../core/colors/app_colors.dart';
import '../bloc/promise_bloc.dart';
import '../bloc/promise_event.dart';
import '../widgets/custom_search_bar.dart';

class SelectPersonScreen extends StatefulWidget {
  const SelectPersonScreen({super.key});

  @override
  State<SelectPersonScreen> createState() => _SelectPersonScreenState();
}

class _SelectPersonScreenState extends State<SelectPersonScreen> {
  final isRecentContactsAvailable = false;

  @override
  void initState() {
    context.read<PromiseBloc>().add(CheckPreviousLoad());
    super.initState();
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

        title: const Text('Select Person'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocConsumer<PromiseBloc, PromiseState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is PromiseInitial) {
                return Column(
                  children: [
                    const Spacer(),
                    ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        // side: const BorderSide(color: Colors.grey),
                      ),
                      tileColor: context.isDark
                          ? AppColors.darkSecondary
                          : AppColors.lightSecondary,
                      title: const Text(
                        'Pick from contacts',
                        style: TextStyle(fontSize: 15),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () async {
                        context.read<PromiseBloc>().add(LoadContacts());
                      },
                    ),
                  ],
                );
              }

              if (state is PromiseLoading) {
                return Center(
                  child: LoadingAnimationWidget.fourRotatingDots(
                    color: context.isDark
                        ? AppColors.lightSecondary
                        : AppColors.darkPrimary,
                    size: 30,
                  ),
                );
              }

              if (state is PromiseError) {
                return Center(child: Text(state.message));
              }

              if (state is PromiseLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSearchBar(
                      hintText: "Search Contacts",
                      // autofocus: true,
                      onChanged: (query) {
                        // print("search => $query");

                        context.read<PromiseBloc>().add(SearchContacts(query));
                      },
                    ),

                    const SizedBox(height: 20),
                    isRecentContactsAvailable
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Recent',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                height: 70,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (_, i) => CircleAvatar(
                                    backgroundColor: context.isDark
                                        ? Colors.white.withOpacity(0.1)
                                        : Colors.black.withOpacity(0.05),
                                    radius: 30,
                                    child: Text(
                                      ['R', 'A', 'M'][i],
                                      style: TextStyle(
                                        color: context.isDark
                                            ? AppColors.lightSecondary
                                            : AppColors.darkPrimary,
                                      ),
                                    ),
                                  ),
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(width: 12),
                                  itemCount: 3,
                                ),
                              ),
                            ],
                          )
                        : SizedBox(),
                    const SizedBox(height: 20),
                    const Text(
                      'All Contacts',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        // iOS-like smooth
                        cacheExtent: 300,
                        // pre-render offscreen items
                        itemCount: state.filteredContacts.length,
                        itemBuilder: (context, index) {
                          final contact = state.filteredContacts[index];

                          return Container(
                            decoration: BoxDecoration(
                              color: context.isDark
                                  ? AppColors.darkSecondary
                                  : AppColors.lightSecondary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: EdgeInsets.only(bottom: 5),
                            child: ListTile(
                              onTap: () {
                                final name =
                                    context
                                            .read<PromiseBloc>()
                                            .promiseModel
                                            .toName =
                                        contact.displayName;
                                final phone =
                                    context
                                        .read<PromiseBloc>()
                                        .promiseModel
                                        .toPhone = contact.phones.isNotEmpty
                                    ? contact.phones.first.number
                                    : '';

                                log('SelectPersonScreen => $name   $phone');
                                context.read<PromiseBloc>().add(
                                  SetPerson(name, phone),
                                );

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (c) => PromisePreviewScreen(),
                                  ),
                                );
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),

                              leading: CircleAvatar(
                                backgroundColor: context.isDark
                                    ? Colors.white.withOpacity(0.1)
                                    : Colors.black.withOpacity(0.05),
                                child: Text(
                                  contact.displayName.isNotEmpty
                                      ? contact.displayName[0]
                                      : '?',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: context.isDark
                                        ? AppColors.lightSecondary
                                        : AppColors.darkPrimary,
                                  ),
                                ),
                              ),
                              title: Text(
                                contact.displayName,
                                style: TextStyle(fontSize: 14),
                              ),
                              subtitle: contact.phones.isNotEmpty
                                  ? Text(
                                      contact.phones.first.number,
                                      style: TextStyle(fontSize: 14),
                                    )
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
              return SizedBox();
            },
          ),
        ),
      ),
    );
  }
}

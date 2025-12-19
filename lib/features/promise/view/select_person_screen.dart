import 'dart:core';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:kept_flutter/core/helper_methods/app_route.dart';
import 'package:kept_flutter/core/helper_methods/helper_method.dart';
import 'package:kept_flutter/features/promise/data/repositories/get_contacts.dart';
import 'package:kept_flutter/features/promise/view/promise_preview_screen.dart';

import '../../../core/colors/app_colors.dart';

class SelectPersonScreen extends StatefulWidget {
  const SelectPersonScreen({super.key,});


  @override
  State<SelectPersonScreen> createState() => _SelectPersonScreenState();
}

class _SelectPersonScreenState extends State<SelectPersonScreen> {
  List<Contact> finalList = [];
   List<Contact> contacts=[];

  final controller = TextEditingController();

  List<Contact> searchContact(String query) {
    var filtered = contacts
        .where(
          (contact) => contact.displayName.toString().toLowerCase().contains(
            query.toString().toLowerCase(),
          ),
        )
        .toList();
    return filtered;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      contacts =await getContacts();
      setState(() {
        finalList = contacts;
      });
    });
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(hint: Text('Search')),
              onChanged: (query) {
                print("search => $query");
                setState(() {
                  finalList = searchContact(query);
                });
              },
            ),

            const SizedBox(height: 20),
            const Text('Recent', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            SizedBox(
              height: 70,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, i) =>
                    CircleAvatar(radius: 30, child: Text(['R', 'A', 'M'][i])),
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemCount: 3,
              ),
            ),
            const Text('Recent', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                // controller: scrollController, //IMPORTANT
                itemCount: finalList.length,
                itemBuilder: (context, index) {
                  final contact = finalList[index];

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
                        Navigator.push(
                          context,
                          AppRoute.smooth(PromisePreviewScreen()),
                        );
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),

                      leading: CircleAvatar(
                        child: Text(
                          contact.displayName.isNotEmpty
                              ? contact.displayName[0]
                              : '?',
                          style: TextStyle(fontSize: 15),
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

            // const Spacer(),
            // ListTile(
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(12),
            //     // side: const BorderSide(color: Colors.grey),
            //   ),
            //   tileColor: context.isDark
            //       ? AppColors.darkSecondary
            //       : AppColors.lightSecondary,
            //   title: const Text(
            //     'Pick from contacts',
            //     style: TextStyle(fontSize: 15),
            //   ),
            //   trailing: const Icon(Icons.chevron_right),
            //   onTap: () async {
            //     final contactsList = await getContacts();
            //     showContactsBottomSheet(context, contactsList, controller);
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

Future<void> showContactsBottomSheet(
  BuildContext context,
  List contacts,
  TextEditingController controller,
) {
  List<String>? resultQuery = [];

  return showModalBottomSheet(
    transitionAnimationController: AnimationController(
      vsync: Navigator.of(context),
      duration: const Duration(milliseconds: 320),
    ),
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    // backgroundColor: AppColors.lightPrimary,
    enableDrag: true,
    useSafeArea: true,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.9,
        //  opens half
        minChildSize: 0.4,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.isDark
                  ? AppColors.darkSecondary
                  : AppColors.lightPrimary,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                // Drag Handle
                Container(
                  width: 48,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                // CustomSearchBar(
                //   controller: controller,
                //   hintText: "Search Contacts",
                //   autofocus: true,
                // ),
                TextField(
                  decoration: InputDecoration(hint: Text('Search')),
                  onChanged: (query) {
                    print("search => $query");
                    // searchContact(query);
                  },
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: ListView.builder(
                    controller: scrollController, //IMPORTANT
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      final contact = contacts[index];

                      return Container(
                        decoration: BoxDecoration(
                          color: context.isDark
                              ? AppColors.darkPrimary
                              : AppColors.lightSecondary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: EdgeInsets.only(bottom: 5),
                        child: ListTile(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => PromisePreviewScreen(),
                            //   ),
                            // );

                            Navigator.push(
                              context,
                              AppRoute.smooth(PromisePreviewScreen()),
                            );
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),

                          leading: CircleAvatar(
                            child: Text(
                              contact.displayName.isNotEmpty
                                  ? contact.displayName[0]
                                  : '?',
                              style: TextStyle(fontSize: 15),
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
            ),
          );
        },
      );
    },
  );
}

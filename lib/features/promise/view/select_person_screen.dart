import 'package:flutter/material.dart';
import 'package:kept_flutter/features/promise/data/repositories/get_contacts.dart';
import 'package:kept_flutter/features/promise/view/promise_details_screen.dart';
import 'package:kept_flutter/features/promise/view/promise_preview_screen.dart';

import '../../../core/colors/app_colors.dart';
import '../widgets/custom_search_bar.dart';

class SelectPersonScreen extends StatelessWidget {
  SelectPersonScreen({super.key});

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPrimary,

      appBar: AppBar(
        backgroundColor: AppColors.lightPrimary,
        title: const Text('Select Person'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            const Spacer(),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                // side: const BorderSide(color: Colors.grey),
              ),
              tileColor: AppColors.whiteColor,
              title: const Text(
                'Pick from contacts',
                style: TextStyle(fontSize: 15),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                final contactsList = await getContacts();
                showContactsBottomSheet(context, contactsList, controller);
              },
            ),
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
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    // backgroundColor: AppColors.lightPrimary,
    enableDrag: true,
    useSafeArea: true,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.9,
        // 👈 opens half
        minChildSize: 0.4,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.lightPrimary,
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

                CustomSearchBar(
                  controller: controller,
                  hintText: "Search Contacts",
                  autofocus: true,
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
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: EdgeInsets.only(bottom: 5),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PromisePreviewScreen(),
                              ),
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
                          title: Text(contact.displayName),
                          subtitle: contact.phones.isNotEmpty
                              ? Text(contact.phones.first.number)
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

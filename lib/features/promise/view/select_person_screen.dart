import 'package:flutter/material.dart';
import 'package:kept_flutter/features/promise/data/repositories/get_contacts.dart';

import '../../../core/colors/app_colors.dart';

class SelectPersonScreen extends StatelessWidget {
  const SelectPersonScreen({super.key});

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
              title: const Text('Pick from contacts'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                final contactsList = await getContacts();
                // print("Mayur contacts $contactsList");
                showContactsBottomSheet(context, contactsList);
              },
            ),
            // ListTile(
            //   title: const Text('Enter phone number'),
            //   trailing: const Icon(Icons.chevron_right),
            //   onTap: () {},
            // ),
          ],
        ),
      ),
    );
  }
}

Future<void> showContactsBottomSheet(context, contacts) {
  return showModalBottomSheet(
    enableDrag: true,
    useSafeArea: true,

    isScrollControlled: true,
    isDismissible: true,
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(),

            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];

                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        contact.displayName.isNotEmpty
                            ? contact.displayName[0]
                            : '?',
                      ),
                    ),
                    title: Text(contact.displayName),
                    subtitle: contact.phones.isNotEmpty
                        ? Text(contact.phones.first.number)
                        : null,
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}

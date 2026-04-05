import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winkwink/generated/l10n/app_localizations.dart';

import '../widgets/winkwink_scaffold.dart';
import '../providers/color_provider.dart';

class ContactsPageEncrypt extends StatefulWidget {
  const ContactsPageEncrypt({super.key});

  @override
  State<ContactsPageEncrypt> createState() => _ContactsPageEncryptState();
}

class _ContactsPageEncryptState extends State<ContactsPageEncrypt> {
  final List<Map<String, String>> contacts = [
    {
      "name": "Alice",
      "qrData": "QR_ALICE_123456",
      "publicKey": "ECC_PUBLIC_KEY_ALICE"
    },
    {
      "name": "Bob",
      "qrData": "QR_BOB_987654",
      "publicKey": "ECC_PUBLIC_KEY_BOB"
    },
    {
      "name": "Carlo",
      "qrData": "QR_CARLO_555555",
      "publicKey": "ECC_PUBLIC_KEY_CARLO"
    },
  ];

  final Set<int> selectedIndexes = {};

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Provider.of<ColorProvider>(context);

    return WinkWinkScaffold(
      showColorSelector: false,
      child: Column(
        children: [
          const SizedBox(height: 10),

          // 🔥 TITOLO MULTILINGUA
          Text(
            l10n.contactsTitle,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: theme.text,
              shadows: const [
                Shadow(
                  blurRadius: 3,
                  color: Colors.black,
                  offset: Offset(1, 1),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // 🔥 SOTTOTITOLO NERO MULTILINGUA
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              l10n.encryptSelectRecipientsSubtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),

          const SizedBox(height: 10),

          // 🔥 LISTA CONTATTI
          Expanded(
            child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final c = contacts[index];
                final selected = selectedIndexes.contains(index);

                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: theme.background.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selected
                          ? theme.background
                          : theme.text.withOpacity(0.3),
                      width: selected ? 2 : 1,
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      c["name"]!,
                      style: TextStyle(
                        color: theme.text,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    // 👇 QR INVISIBILE
                    subtitle: const SizedBox.shrink(),

                    trailing: Checkbox(
                      value: selected,
                      activeColor: theme.background,
                      checkColor: theme.text,
                      onChanged: (_) {
                        setState(() {
                          if (selected) {
                            selectedIndexes.remove(index);
                          } else {
                            selectedIndexes.add(index);
                          }
                        });
                      },
                    ),

                    onTap: () {
                      setState(() {
                        if (selected) {
                          selectedIndexes.remove(index);
                        } else {
                          selectedIndexes.add(index);
                        }
                      });
                    },
                  ),
                );
              },
            ),
          ),

          // 🔥 PULSANTE OK
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.background,
                foregroundColor: theme.text,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {
                final selectedContacts =
                    selectedIndexes.map((i) => contacts[i]).toList();

                Navigator.pop(context, selectedContacts);
              },
              child: const Text(
                "OK! 👍",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

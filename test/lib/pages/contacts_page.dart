import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winkwink/generated/l10n/app_localizations.dart';

import '../widgets/winkwink_scaffold.dart';
import '../providers/color_provider.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  bool selectionMode = false;

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
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments;

    if (args is Map && args["selectionMode"] == true) {
      selectionMode = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Provider.of<ColorProvider>(context);

    return WinkWinkScaffold(
      showColorSelector: false,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            selectionMode ? l10n.encryptSelectRecipients : l10n.contactsTitle,
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
                    subtitle: const SizedBox.shrink(),
                    trailing: selectionMode
                        ? Checkbox(
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
                          )
                        : Icon(Icons.chevron_right, color: theme.text),
                    onTap: () {
                      if (!selectionMode) {
                        // TODO: dettaglio contatto
                      } else {
                        setState(() {
                          if (selected) {
                            selectedIndexes.remove(index);
                          } else {
                            selectedIndexes.add(index);
                          }
                        });
                      }
                    },
                  ),
                );
              },
            ),
          ),
          if (selectionMode)
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
                child: Text(
                  l10n.forwardButton,
                  style: const TextStyle(
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

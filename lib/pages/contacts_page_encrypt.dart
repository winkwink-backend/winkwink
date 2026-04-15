import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winkwink/generated/l10n.dart';

import '../widgets/winkwink_scaffold.dart';
import '../providers/color_provider.dart';
import '../services/storage_service.dart';
import '../models/ww_contact.dart';

class ContactsPageEncrypt extends StatefulWidget {
  const ContactsPageEncrypt({super.key});

  @override
  State<ContactsPageEncrypt> createState() => _ContactsPageEncryptState();
}

class _ContactsPageEncryptState extends State<ContactsPageEncrypt> {
  List<Map<String, String>> contacts = [];
  final Set<int> selectedIndexes = {};
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  // ------------------------------------------------------------
  // 🔥 CARICA I CONTATTI REALI
  // ------------------------------------------------------------
  Future<void> _loadContacts() async {
    final List<WWContact> wwContacts = await StorageService.getWWContacts();

    contacts = wwContacts
        .where((c) =>
            c.publicKey != null &&
            c.publicKey!.isNotEmpty &&
            c.userId != null &&
            c.userId!.isNotEmpty)
        .map((c) => {
              "name": c.name,
              "publicKey": c.publicKey!,
              "userId": c.userId!,
            })
        .toList();

    setState(() => loading = false);
  }

  // ------------------------------------------------------------
  // 🔥 ELIMINA UN CONTATTO
  // ------------------------------------------------------------
  Future<void> _deleteContact(Map<String, String> contact) async {
    final userId = contact["userId"];
    if (userId == null) return;

    await StorageService.deleteContact(userId);
    await _loadContacts();

    _showInfo(
      S.of(context)!.contactDeleted,
      S.of(context)!.contactDeletedMessage,
    );
  }

  // ------------------------------------------------------------
  // 🔥 DIALOGO RAPIDO
  // ------------------------------------------------------------
  void _showInfo(String title, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            child: Text(S.of(context)!.okButton),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;
    final theme = Provider.of<ColorProvider>(context);

    return WinkWinkScaffold(
      showColorSelector: false,
      child: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const SizedBox(height: 10),

                // 🔥 TITOLO
                Text(
                  l10n.encryptSelectRecipients,
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

                // 🔥 SOTTOTITOLO
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    l10n.encryptSelectRecipientsSubtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: theme.text.withOpacity(0.7),
                      fontSize: 16,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // 🔥 LISTA CONTATTI
                Expanded(
                  child: contacts.isEmpty
                      ? Center(
                          child: Text(
                            l10n.encryptNoContactsAvailable,
                            style: TextStyle(color: theme.text),
                          ),
                        )
                      : ListView.builder(
                          itemCount: contacts.length,
                          itemBuilder: (context, index) {
                            final c = contacts[index];
                            final selected = selectedIndexes.contains(index);

                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: theme.background.withOpacity(0.25),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: selected
                                      ? theme.primary
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
                                subtitle: Text(
                                  "Chiave ECC presente",
                                  style: TextStyle(
                                    color: theme.text.withOpacity(0.6),
                                    fontSize: 14,
                                  ),
                                ),

                                // ⭐ AGGIUNTA ICONA CESTINO
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Checkbox(
                                      value: selected,
                                      activeColor: theme.primary,
                                      checkColor: Colors.white,
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
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.redAccent),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            title: Text(l10n.contactDeleted),
                                            content: Text(
                                              "Vuoi davvero eliminare questo contatto?",
                                            ),
                                            actions: [
                                              TextButton(
                                                child: Text(l10n.cancelButton),
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                              ),
                                              TextButton(
                                                child: Text(l10n.deleteButton),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  _deleteContact(c);
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
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
                      backgroundColor: theme.primary,
                      foregroundColor: Colors.white,
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

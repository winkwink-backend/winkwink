import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:contacts_service_plus/contacts_service_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:winkwink/generated/l10n.dart';
import '../widgets/winkwink_scaffold.dart';
import '../providers/color_provider.dart';
import 'package:winkwink/config/app_config.dart';
import 'package:winkwink/services/storage_service.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  bool loading = true;

  List<Map<String, dynamic>> wwContacts = [];
  List<Map<String, dynamic>> nonWwContacts = [];

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    setState(() => loading = true);

    // 🔥 1. Contatti WinkWink salvati internamente
    final saved = await StorageService.getWWContacts();
    List<Map<String, dynamic>> ww = saved.map((c) => c.toJson()).toList();
    List<Map<String, dynamic>> nonWw = [];

    // 🔥 2. Contatti della rubrica
    final status = await Permission.contacts.request();
    if (status.isGranted) {
      final Iterable<Contact> deviceContacts =
          await ContactsService.getContacts(withThumbnails: false);

      for (final c in deviceContacts) {
        if (c.phones == null || c.phones!.isEmpty) continue;

        final phone = c.phones!.first.value?.replaceAll(" ", "") ?? "";
        if (phone.isEmpty) continue;

        try {
          final res = await http.get(
            Uri.parse("${AppConfig.baseUrl}/users/check?phone=$phone"),
          );

          if (res.statusCode == 200) {
            final data = jsonDecode(res.body);

            if (data["exists"] == true) {
              // Evita duplicati
              if (!ww.any((x) => x["userId"] == data["userId"])) {
                ww.add({
                  "name": c.displayName ?? "Senza nome",
                  "lastName": "",
                  "phone": phone,
                  "userId": data["userId"],
                  "publicKey": null,
                  "qrData": "",
                });
              }
            } else {
              nonWw.add({
                "name": c.displayName ?? "Senza nome",
                "phone": phone,
              });
            }
          }
        } catch (_) {}
      }
    }

    setState(() {
      wwContacts = ww;
      nonWwContacts = nonWw;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;
    final theme = Provider.of<ColorProvider>(context);

    return WinkWinkScaffold(
      showColorSelector: false,
      child: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const SizedBox(height: 10),

                Text(
                  l10n.contactsTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: theme.text,
                  ),
                ),

                const SizedBox(height: 20),

                // ⭐ CONTATTI WINKWINK
                if (wwContacts.isNotEmpty)
                  Text(
                    "Contatti WinkWink",
                    style: TextStyle(
                      color: theme.text,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ...wwContacts.map((c) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: theme.background.withOpacity(0.35),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(
                        c["name"],
                        style: TextStyle(color: theme.text),
                      ),
                      subtitle: Text(
                        c["phone"],
                        style: TextStyle(color: theme.text.withOpacity(0.7)),
                      ),

                      // ⭐ CHAT + QR
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.chat, color: theme.text),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                "/chat",
                                arguments: {
                                  "otherId": c["userId"],
                                  "name": c["name"],
                                },
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.qr_code, color: theme.text),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                "/sendQr",
                                arguments: {"userId": c["userId"]},
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 30),

                // ⭐ CONTATTI NON WINKWINK
                if (nonWwContacts.isNotEmpty)
                  Text(
                    "Invita su WinkWink",
                    style: TextStyle(
                      color: theme.text,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ...nonWwContacts.map((c) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: theme.background.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(
                        c["name"],
                        style: TextStyle(color: theme.text),
                      ),
                      subtitle: Text(
                        c["phone"],
                        style: TextStyle(color: theme.text.withOpacity(0.7)),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.send, color: theme.text),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Invito inviato a ${c["name"]}"),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }),
              ],
            ),
    );
  }
}

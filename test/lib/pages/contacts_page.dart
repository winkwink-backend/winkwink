import 'package:flutter/material.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  bool selectionMode = false;

  // CONTATTI FITTIZI PER TEST
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

    // 🔥 LEGGIAMO GLI ARGOMENTI PASSATI DALLA PAGINA CRIPTA
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args is Map && args["selectionMode"] == true) {
      selectionMode = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectionMode ? "Seleziona contatti" : "Contatti WW"),
      ),

      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final c = contacts[index];
          final selected = selectedIndexes.contains(index);

          return ListTile(
            title: Text(c["name"]!),
            subtitle: Text("QR: ${c["qrData"]}"),

            trailing: selectionMode
                ? Checkbox(
                    value: selected,
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
                : const Icon(Icons.chevron_right),

            onTap: () {
              if (!selectionMode) {
                // Modalità normale (dalla Home)
                // TODO: apri dettaglio contatto
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
          );
        },
      ),

      // 🔥 FOOTER SOLO IN MODALITÀ SELEZIONE
      bottomNavigationBar: selectionMode
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  final selectedContacts = selectedIndexes
                      .map((i) => contacts[i])
                      .toList();

                  Navigator.pop(context, selectedContacts);
                },
                child: const Text("Conferma selezione"),
              ),
            )
          : null,
    );
  }
}
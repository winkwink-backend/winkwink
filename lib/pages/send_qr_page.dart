import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:provider/provider.dart';

import 'package:winkwink/generated/l10n.dart';
import 'package:winkwink/services/storage_service.dart';
import 'package:winkwink/providers/color_provider.dart';
import 'package:winkwink/models/ww_contact.dart';
import '../widgets/winkwink_scaffold.dart';

class SendQrPage extends StatefulWidget {
  const SendQrPage({super.key});

  @override
  State<SendQrPage> createState() => _SendQrPageState();
}

class _SendQrPageState extends State<SendQrPage> {
  String _qrData = 'NESSUN_QR';
  bool loadingContacts = true;
  List<Map<String, dynamic>> wwContacts = [];

  @override
  void initState() {
    super.initState();
    _loadQr();
    _loadContacts();
  }

  // ------------------------------------------------------------
  // 🔥 CARICA IL QR SALVATO (nuovo formato o legacy)
  // ------------------------------------------------------------
  Future<void> _loadQr() async {
    final savedQr = await StorageService.getQrData();

    if (!mounted) return;

    if (savedQr == null) {
      setState(() => _qrData = 'NESSUN_QR');
      return;
    }

    // Verifica se è Base64 valido → nuovo formato
    bool isBase64 = false;
    try {
      final decoded = utf8.decode(base64Decode(savedQr));
      final json = jsonDecode(decoded);

      if (json is Map && json["type"] == "WW_ID") {
        isBase64 = true;
      }
    } catch (_) {}

    setState(() {
      _qrData = savedQr; // sia base64 che legacy funzionano
    });
  }

  // ------------------------------------------------------------
  // 🔥 CARICA CONTATTI WINKWINK SALVATI
  // ------------------------------------------------------------
  Future<void> _loadContacts() async {
    setState(() => loadingContacts = true);

    final saved = await StorageService.getWWContacts();
    wwContacts = saved.map((c) => c.toJson()).toList();

    setState(() => loadingContacts = false);
  }

  // ------------------------------------------------------------
  // 🔥 INVIO QR (placeholder)
  // ------------------------------------------------------------
  Future<void> _sendQrToContact(Map<String, dynamic> c) async {
    final l10n = S.of(context)!;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${l10n.sendQrSentTo} ${c["name"]}")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;
    final theme = Provider.of<ColorProvider>(context);

    return WinkWinkScaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.4),
        elevation: 0,
        title: Text(l10n.sendQrTitle),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.sendQrDescription,
              style: const TextStyle(color: Colors.white),
            ),

            const SizedBox(height: 24),

            // 🔥 QR GRANDE
            Center(
              child: QrImageView(
                data: _qrData,
                version: QrVersions.auto,
                size: 220,
                backgroundColor: Colors.white,
              ),
            ),

            const SizedBox(height: 24),

            Text(
              l10n.sendQrContactsTitle,
              style: TextStyle(
                color: theme.text,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: loadingContacts
                  ? const Center(child: CircularProgressIndicator())
                  : wwContacts.isEmpty
                      ? Text(
                          l10n.sendQrNoContacts,
                          style: TextStyle(color: theme.text),
                        )
                      : ListView.builder(
                          itemCount: wwContacts.length,
                          itemBuilder: (_, i) {
                            final c = wwContacts[i];
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              decoration: BoxDecoration(
                                color: theme.background.withOpacity(0.25),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                title: Text(
                                  c["name"],
                                  style: TextStyle(color: theme.text),
                                ),
                                subtitle: Text(
                                  c["phone"],
                                  style: TextStyle(
                                    color: theme.text.withOpacity(0.7),
                                  ),
                                ),
                                trailing: ElevatedButton(
                                  onPressed: () => _sendQrToContact(c),
                                  child: Text(l10n.sendQrButton),
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

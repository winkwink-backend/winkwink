import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winkwink/generated/l10n.dart';

import '../widgets/winkwink_scaffold.dart';
import '../providers/color_provider.dart';
import '../services/messages_service.dart';
import '../services/storage_service.dart';
import '../services/ecc_service.dart';
import '../services/api_service.dart';
import '../models/ww_contact.dart';
import '../routes.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({super.key});

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  List<Map<String, dynamic>> inbox = [];
  int? userId;

  @override
  void initState() {
    super.initState();
    _loadUserAndInbox();
  }

  Future<void> _loadUserAndInbox() async {
    userId = await StorageService.getUserId();
    if (userId == null) return;

    final list = await MessagesService.getInbox(userId!);
    setState(() => inbox = list);
  }

  // ------------------------------------------------------------
  // ⭐ ACCETTA INVITO
  // ------------------------------------------------------------
  Future<void> _acceptInvite(Map<String, dynamic> item) async {
    final l10n = S.of(context)!;

    final payload = item["payload"];
    final fromUserId = item["from_user_id"];

    final ecc = ECCService();

    final otherPublicKey = await ecc.fetchUserPublicKey(fromUserId);

    if (otherPublicKey == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.inboxErrorNoKey)),
      );
      return;
    }

    final profile = await StorageService.getProfile();
    final myName = "${profile["name"]} ${profile["surname"]}";
    final myEmail = profile["email"] ?? "";

    final myKeys = await StorageService.getECCKeys();

    final contact = WWContact(
      name: payload["name"] ?? "Utente",
      lastName: "",
      userId: fromUserId.toString(),
      phone: payload["phone"] ?? "",
      publicKey: otherPublicKey,
      qrData: payload["qrData"] ?? "",
    );

    await StorageService.saveOrUpdateWWContact(contact);

    await ApiService.post("/inbox/create", {
      "to_user_id": fromUserId,
      "from_user_id": userId,
      "type": "invite_accept",
      "payload": {
        "name": myName,
        "public_key": myKeys["publicKey"],
        "qrData": await StorageService.getQrData(),
        "phone": myEmail,
      }
    });

    await _loadUserAndInbox();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.inboxContactAdded)),
    );
  }

  // ------------------------------------------------------------
  // ⭐ RIFIUTA INVITO
  // ------------------------------------------------------------
  Future<void> _rejectInvite(Map<String, dynamic> item) async {
    await StorageService.removeInboxItem(item);
    await _loadUserAndInbox();
  }

  // ------------------------------------------------------------
  // ⭐ APRI NOTIFICA
  // ------------------------------------------------------------
  Future<void> _openItem(Map<String, dynamic> item) async {
    final l10n = S.of(context)!;

    final type = item["type"];
    final payload = item["payload"];

    // ⭐ INVITO
    if (type == "invite") {
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(l10n.inboxInviteDialogTitle),
          content: Text(
            l10n.inboxInviteDialogMessage(payload["name"] ?? "Utente"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _rejectInvite(item);
              },
              child: Text(l10n.inboxReject),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _acceptInvite(item);
              },
              child: Text(l10n.inboxAccept),
            ),
          ],
        ),
      );
      return;
    }

    // ⭐ ACCETTAZIONE INVITO
    if (type == "invite_accept") {
      final fromUserId = item["from_user_id"];
      final otherPublicKey = payload["public_key"];

      final contact = WWContact(
        name: payload["name"] ?? "Utente",
        lastName: "",
        userId: fromUserId.toString(),
        phone: payload["phone"] ?? "",
        publicKey: otherPublicKey,
        qrData: payload["qrData"] ?? "",
      );

      await StorageService.saveOrUpdateWWContact(contact);

      await _loadUserAndInbox();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.inboxContactAdded)),
      );

      return;
    }

    // ⭐ QR ricevuto
    if (type == "qr_received") {
      await Navigator.pushNamed(
        context,
        AppRoutes.scanQr,
        arguments: {"qrData": payload},
      );
      return;
    }

    // ⭐ Messaggio
    if (type == "message") {
      await Navigator.pushNamed(
        context,
        AppRoutes.chat,
        arguments: {
          "contactId": item["from_user_id"],
          "contactName": "Utente ${item["from_user_id"]}",
        },
      );
      return;
    }

    // ⭐ Richiesta P2P
    if (type == "file_transfer_request") {
      await Navigator.pushNamed(
        context,
        AppRoutes.p2pReceive,
        arguments: payload,
      );
      return;
    }

    await _loadUserAndInbox();
  }

  // ------------------------------------------------------------
  // UI
  // ------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ColorProvider>(context);
    final l10n = S.of(context)!;

    return WinkWinkScaffold(
      showColorSelector: false,
      appBar: AppBar(
        title: Text(
          l10n.inboxTitle,
          style: TextStyle(color: theme.text),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: theme.text),
      ),
      child: inbox.isEmpty
          ? Center(
              child: Text(
                l10n.noNotifications,
                style: TextStyle(
                  color: theme.text,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: inbox.length,
              itemBuilder: (context, index) {
                final item = inbox[index];
                final type = item["type"];
                final payload = item["payload"];

                // ⭐ Titolo dinamico
                String title;
                if (type == "invite") {
                  title = l10n.inboxInviteTitle(payload["name"] ?? "Utente");
                } else if (type == "invite_accept") {
                  title =
                      l10n.inboxInviteAcceptTitle(payload["name"] ?? "Utente");
                } else if (type == "message") {
                  title =
                      l10n.inboxMessageTitle(item["from_user_id"].toString());
                } else if (type == "file_transfer_request") {
                  title = l10n.inboxFileRequestTitle;
                } else {
                  title = l10n.notificationGeneric;
                }

                // ⭐ Sottotitolo dinamico
                String subtitle;
                if (type == "invite") {
                  subtitle = l10n.inboxInviteSubtitle;
                } else if (type == "invite_accept") {
                  subtitle = l10n.inboxInviteAcceptSubtitle;
                } else if (type == "message") {
                  subtitle = payload?["preview"] ?? l10n.inboxMessageSubtitle;
                } else if (type == "file_transfer_request") {
                  subtitle = l10n.inboxFileRequestSubtitle(
                    payload?["fileType"] ?? "",
                    payload?["fileSize"]?.toString() ?? "0",
                  );
                } else {
                  subtitle = item["created_at"] ?? "";
                }

                // ⭐ Icona dinamica
                IconData icon;
                if (type == "invite") {
                  icon = Icons.person_add_alt;
                } else if (type == "invite_accept") {
                  icon = Icons.check_circle_outline;
                } else if (type == "message") {
                  icon = Icons.chat_bubble_outline;
                } else if (type == "file_transfer_request") {
                  icon = Icons.file_present;
                } else {
                  icon = Icons.notifications;
                }

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: theme.background.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: theme.text.withOpacity(0.3),
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(icon, color: theme.text),
                    title: Text(
                      title,
                      style: TextStyle(
                        color: theme.text,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      subtitle,
                      style: TextStyle(color: theme.text.withOpacity(0.7)),
                    ),
                    onTap: () => _openItem(item),
                  ),
                );
              },
            ),
    );
  }
}

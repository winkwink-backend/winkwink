import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/winkwink_scaffold.dart';
import '../providers/color_provider.dart';
import '../services/storage_service.dart';
import 'package:winkwink/generated/l10n.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool sendOnlyWifi = false;
  bool receiveOnlyWifi = false;
  bool notifyWingSound = false;
  bool notifySendComplete = false;
  bool notifyReceiveComplete = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  // ------------------------------------------------------------
  // 🔥 CARICA LE IMPOSTAZIONI SALVATE
  // ------------------------------------------------------------
  Future<void> _loadSettings() async {
    sendOnlyWifi = await StorageService.getBool("sendOnlyWifi") ?? false;
    receiveOnlyWifi = await StorageService.getBool("receiveOnlyWifi") ?? false;
    notifyWingSound = await StorageService.getBool("notifyWingSound") ?? false;
    notifySendComplete =
        await StorageService.getBool("notifySendComplete") ?? false;
    notifyReceiveComplete =
        await StorageService.getBool("notifyReceiveComplete") ?? false;

    if (mounted) setState(() {});
  }

  // ------------------------------------------------------------
  // 🔥 SALVA UNA SINGOLA IMPOSTAZIONE
  // ------------------------------------------------------------
  Future<void> _saveSetting(String key, bool value) async {
    await StorageService.setBool(key, value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ColorProvider>(context);
    final l10n = S.of(context)!;

    return WinkWinkScaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.4),
        elevation: 0,
        title: const Text("Impostazioni"),
      ),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 10),

          // ⭐ 1 — INVIA SOLO IN WIFI
          SwitchListTile(
            title: const Text("Invia file solo tramite Wi‑Fi",
                style: TextStyle(color: Colors.white)),
            subtitle: const Text(
              "Evita l'uso dei dati mobili durante l'invio",
              style: TextStyle(color: Colors.white70),
            ),
            value: sendOnlyWifi,
            onChanged: (v) {
              setState(() => sendOnlyWifi = v);
              _saveSetting("sendOnlyWifi", v);
            },
          ),

          // ⭐ 2 — RICEVI SOLO IN WIFI
          SwitchListTile(
            title: const Text("Ricevi file solo tramite Wi‑Fi",
                style: TextStyle(color: Colors.white)),
            subtitle: const Text(
              "Evita l'uso dei dati mobili durante la ricezione",
              style: TextStyle(color: Colors.white70),
            ),
            value: receiveOnlyWifi,
            onChanged: (v) {
              setState(() => receiveOnlyWifi = v);
              _saveSetting("receiveOnlyWifi", v);
            },
          ),

          const Divider(color: Colors.white38, height: 40),

          // ⭐ 3 — SUONO WING (notifica ingresso)
          SwitchListTile(
            title: const Text("Suono Wing per nuovi messaggi",
                style: TextStyle(color: Colors.white)),
            subtitle: const Text(
              "Riproduce un suono quando arriva un nuovo messaggio",
              style: TextStyle(color: Colors.white70),
            ),
            value: notifyWingSound,
            onChanged: (v) {
              setState(() => notifyWingSound = v);
              _saveSetting("notifyWingSound", v);
            },
          ),

          // ⭐ 4 — SUONO WINKWINK (invio completato)
          SwitchListTile(
            title: const Text("Suono WinkWink a invio completato",
                style: TextStyle(color: Colors.white)),
            subtitle: const Text(
              "Riproduce un suono quando un file è stato inviato",
              style: TextStyle(color: Colors.white70),
            ),
            value: notifySendComplete,
            onChanged: (v) {
              setState(() => notifySendComplete = v);
              _saveSetting("notifySendComplete", v);
            },
          ),

          // ⭐ 5 — SUONO WINKWINK (ricezione completata)
          SwitchListTile(
            title: const Text("Suono WinkWink a ricezione completata",
                style: TextStyle(color: Colors.white)),
            subtitle: const Text(
              "Riproduce un suono quando un file è stato ricevuto",
              style: TextStyle(color: Colors.white70),
            ),
            value: notifyReceiveComplete,
            onChanged: (v) {
              setState(() => notifyReceiveComplete = v);
              _saveSetting("notifyReceiveComplete", v);
            },
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

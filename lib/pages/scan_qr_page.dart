import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

import '../widgets/winkwink_scaffold.dart';
import '../providers/color_provider.dart';
import '../services/storage_service.dart';
import '../services/wwgallery_service.dart';
import 'package:winkwink/generated/l10n.dart';
import 'package:winkwink/models/ww_contact.dart';
import 'package:crypto/crypto.dart';

class ScanQrPage extends StatefulWidget {
  const ScanQrPage({super.key});

  @override
  State<ScanQrPage> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  bool _processing = false;

  // ------------------------------------------------------------
  // 🔥 PROCESSA IL QR TROVATO
  // ------------------------------------------------------------
  Future<void> _handleQr(String qrData) async {
    if (_processing) return;
    _processing = true;

    final l10n = S.of(context)!;

    try {
      // ============================================================
      // 1) PROVA NUOVO FORMATO JSON BASE64
      // ============================================================
      final contact = _tryParseNewFormat(qrData);

      if (contact != null) {
        await _saveContact(contact, qrData);
        return;
      }

      // ============================================================
      // 2) PROVA FORMATO LEGACY "WW|..."
      // ============================================================
      final legacy = _tryParseLegacy(qrData);

      if (legacy != null) {
        await _saveContact(legacy, qrData);
        return;
      }

      // ============================================================
      // 3) QR NON VALIDO
      // ============================================================
      _showInfo(l10n.errorTitle, l10n.invalidQr);
    } catch (e) {
      _showInfo(l10n.errorTitle, "${l10n.invalidQr}\n$e");
    }

    _processing = false;
  }

  // ------------------------------------------------------------
  // ⭐ PARSE NUOVO FORMATO JSON BASE64
  // ------------------------------------------------------------
  WWContact? _tryParseNewFormat(String qrData) {
    try {
      // Se non è Base64 valido → fallisce
      final decoded = utf8.decode(base64Decode(qrData));
      final json = jsonDecode(decoded);

      if (json["type"] != "WW_ID") return null;
      if (json["version"] != 2) return null;

      // Verifica fingerprint
      final fingerprint = json["fingerprint"];
      final tmp = Map<String, dynamic>.from(json);
      tmp.remove("fingerprint");

      final check = sha256.convert(utf8.encode(jsonEncode(tmp))).toString();
      if (check != fingerprint) {
        throw Exception("Fingerprint mismatch");
      }

      return WWContact(
        userId: json["userId"],
        name: json["firstName"],
        lastName: json["lastName"],
        phone: json["phone"],
        publicKey: json["publicKey"],
        peerId: json["peerId"],
        fingerprint: fingerprint,
        version: 2,
        qrData: qrData,
      );
    } catch (_) {
      return null;
    }
  }

  // ------------------------------------------------------------
  // ⭐ PARSE FORMATO LEGACY "WW|..."
  // ------------------------------------------------------------
  WWContact? _tryParseLegacy(String qrData) {
    if (!qrData.startsWith("WW|")) return null;

    final parts = qrData.split("|");
    if (parts.length != 6) return null;

    return WWContact(
      userId: parts[1],
      name: parts[2],
      lastName: parts[3],
      phone: parts[4],
      publicKey: parts[5],
      version: 1,
      qrData: qrData,
    );
  }

  // ------------------------------------------------------------
  // ⭐ SALVA CONTATTO + QR IN GALLERIA
  // ------------------------------------------------------------
  Future<void> _saveContact(WWContact contact, String qrData) async {
    final l10n = S.of(context)!;

    await StorageService.saveOrUpdateWWContact(contact);
    await WWGalleryService.saveQr(qrData);

    if (!mounted) return;

    _showInfo(
      l10n.contactAddedTitle,
      "${contact.name} ${contact.lastName} ${l10n.contactAddedMessage}",
      onClose: () => Navigator.pop(context),
    );

    _processing = false;
  }

  // ------------------------------------------------------------
  // 🔥 DIALOGO RAPIDO
  // ------------------------------------------------------------
  void _showInfo(String title, String message, {VoidCallback? onClose}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.pop(context);
              if (onClose != null) onClose();
            },
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
      child: Stack(
        children: [
          // ------------------------------------------------------------
          // 🔥 CAMERA LIVE
          // ------------------------------------------------------------
          MobileScanner(
            onDetect: (capture) {
              final barcodes = capture.barcodes;
              if (barcodes.isEmpty) return;

              final value = barcodes.first.rawValue;
              if (value == null) return;

              _handleQr(value);
            },
          ),

          // ------------------------------------------------------------
          // 🔲 QUADRATO CENTRALE
          // ------------------------------------------------------------
          Center(
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                border: Border.all(
                  color: theme.text,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),

          // ------------------------------------------------------------
          // 🔤 TITOLO IN ALTO
          // ------------------------------------------------------------
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Text(
              l10n.scanQrTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: theme.text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

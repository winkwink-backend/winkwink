import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:winkwink/generated/l10n/app_localizations.dart';

import '../widgets/neon_button.dart';
import '../widgets/ww_dialogs.dart';
import '../widgets/winkwink_scaffold.dart';

import '../services/steganography_service.dart';
import '../services/storage_service.dart';

import '../providers/color_provider.dart';

class DecryptPage extends StatefulWidget {
  const DecryptPage({super.key});

  @override
  State<DecryptPage> createState() => _DecryptPageState();
}

class _DecryptPageState extends State<DecryptPage> {
  final ImagePicker _picker = ImagePicker();

  String? _imagePath;
  Map<String, dynamic>? _payload;
  Map<String, dynamic>? _secret;

  bool _loading = false;

  Future<void> _pickImage() async {
    final XFile? img = await _picker.pickImage(source: ImageSource.gallery);

    if (!mounted) return;

    if (img != null) {
      setState(() {
        _imagePath = img.path;
        _payload = null;
        _secret = null;
      });
    }
  }

  Future<void> _decrypt() async {
    final l10n = AppLocalizations.of(context)!;

    if (_imagePath == null) {
      await showInfoDialog(
        context,
        title: l10n.decryptError,
        message: l10n.decryptMissingImage,
      );
      return;
    }

    setState(() => _loading = true);

    try {
      // 1. Estrai bytes
      final extractedBytes = await SteganographyService().extractPayload(
        imagePath: _imagePath!,
      );

      if (extractedBytes.isEmpty) {
        throw Exception("Payload vuoto o non trovato");
      }

      // 2. Bytes → JSON
      late final Map<String, dynamic> payload;

      try {
        final jsonString = utf8.decode(extractedBytes);
        payload = jsonDecode(jsonString);
      } catch (_) {
        throw Exception("Payload corrotto o non valido");
      }

      // 3. Recupera chiavi ECC
      final eccKeys = await StorageService.getECCKeys();
      final myPrivateKey = eccKeys["privateKey"];
      final myPublicKey = eccKeys["publicKey"];

      if (myPrivateKey == null || myPublicKey == null) {
        throw Exception("Chiavi ECC personali mancanti");
      }

      // 4. Universal Key
      final universalKey = await StorageService.getUniversalKey();

      // 5. Verifica destinatari
      if (!payload.containsKey("recipients")) {
        throw Exception("Campo recipients mancante");
      }

      final List recipients = payload["recipients"];

      Map<String, dynamic>? myRecipientEntry;

      for (final r in recipients) {
        if (r["publicKey"] == myPublicKey) {
          myRecipientEntry = r;
          break;
        }
      }

      if (myRecipientEntry == null && universalKey == null) {
        throw Exception("Non sei tra i destinatari");
      }

      // 6. Shared secret
      final sharedSecret = universalKey ?? myRecipientEntry!["sharedSecret"];

      if (sharedSecret == null) {
        throw Exception("Shared secret mancante");
      }

      // 7. Secret vero
      if (!payload.containsKey("secret")) {
        throw Exception("Campo secret mancante");
      }

      final secret = payload["secret"];

      setState(() {
        _payload = payload;
        _secret = secret;
      });

      await showInfoDialog(
        context,
        title: l10n.decryptSuccess,
        message: l10n.decryptSuccessMessage,
      );
    } catch (e) {
      if (!mounted) return;

      await showInfoDialog(
        context,
        title: l10n.decryptError,
        message: e.toString(),
      );
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  Widget _buildSecret(Color textColor) {
    if (_secret == null) return const SizedBox.shrink();

    final type = _secret!["type"];

    switch (type) {
      case "text":
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.25),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            _secret!["data"],
            style: TextStyle(fontSize: 16, color: textColor),
          ),
        );

      case "image":
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.memory(
            base64Decode(_secret!["data"]),
            fit: BoxFit.contain,
          ),
        );

      case "audio":
        return _buildInfoBox(
          "Audio (${_secret!["data"].length} bytes)\nPlayback coming soon.",
          textColor,
        );

      case "video":
        return _buildInfoBox(
          "Video (${_secret!["data"].length} bytes)\nPlayback coming soon.",
          textColor,
        );

      case "sandwich":
        return _buildInfoBox(
          "Sandwich con ${_secret!["layers"].length} livelli.\nUI coming soon.",
          textColor,
        );

      default:
        return Text(
          "Tipo sconosciuto: $type",
          style: TextStyle(color: textColor),
        );
    }
  }

  Widget _buildInfoBox(String text, Color textColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.25),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16, color: textColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Provider.of<ColorProvider>(context);

    return WinkWinkScaffold(
      showColorSelector: false,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            Text(
              l10n.decryptTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
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
            Text(
              l10n.decryptDescription,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            NeonButton(
              label: l10n.decryptPickImage,
              onPressed: () {
                if (!_loading) _pickImage();
              },
            ),
            if (_imagePath != null) ...[
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(_imagePath!),
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ],
            const SizedBox(height: 20),
            NeonButton(
              label: _loading ? l10n.decrypting : l10n.decryptButton,
              onPressed: () {
                if (!_loading) _decrypt();
              },
            ),
            if (_secret != null) ...[
              const SizedBox(height: 30),
              Text(
                l10n.decryptResult,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: theme.text,
                ),
              ),
              const SizedBox(height: 10),
              _buildSecret(theme.text),
            ],
          ],
        ),
      ),
    );
  }
}

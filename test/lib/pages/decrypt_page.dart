import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:winkwink/generated/l10n/app_localizations.dart';

import '../widgets/neon_button.dart';
import '../widgets/ww_dialogs.dart';
import '../services/crypto_service.dart';

class DecryptPage extends StatefulWidget {
  const DecryptPage({super.key});

  @override
  State<DecryptPage> createState() => _DecryptPageState();
}

class _DecryptPageState extends State<DecryptPage> {
  final _crypto = CryptoService();
  final ImagePicker _picker = ImagePicker();

  String? _imagePath;

  // Risultato della decriptazione
  List<int>? _decryptedBytes;
  PayloadType? _payloadType;

  /// Seleziona l'immagine PNG criptata
  Future<void> _pickImage() async {
    final XFile? img = await _picker.pickImage(source: ImageSource.gallery);

    if (!mounted) return;

    if (img != null) {
      setState(() {
        _imagePath = img.path;
        _decryptedBytes = null;
        _payloadType = null;
      });
    }
  }

  /// Decripta il file
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

    try {
      final result = await _crypto.decrypt(_imagePath!);

      if (!mounted) return;

      setState(() {
        _decryptedBytes = result.bytes;
        _payloadType = result.type;
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
    }
  }

  Widget _buildDecryptedContent() {
    if (_decryptedBytes == null || _payloadType == null) {
      return const SizedBox.shrink();
    }

    switch (_payloadType!) {
      case PayloadType.text:
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            String.fromCharCodes(_decryptedBytes!),
            style: const TextStyle(fontSize: 14),
          ),
        );

      case PayloadType.image:
        return Image.memory(
          Uint8List.fromList(_decryptedBytes!),
          fit: BoxFit.contain,
        );

      case PayloadType.audio:
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "Audio decrypted (${_decryptedBytes!.length} bytes)\n"
            "Playback support coming soon.",
            style: const TextStyle(fontSize: 14),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.decryptTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              l10n.decryptDescription,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            NeonButton(
              label: l10n.decryptPickImage,
              onPressed: _pickImage,
            ),

            if (_imagePath != null) ...[
              const SizedBox(height: 16),
              Image.file(
                File(_imagePath!),
                height: 200,
                fit: BoxFit.cover,
              ),
            ],

            const SizedBox(height: 20),

            NeonButton(
              label: l10n.decryptButton,
              onPressed: _decrypt,
            ),

            if (_decryptedBytes != null) ...[
              const SizedBox(height: 30),
              Text(
                l10n.decryptResult,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              _buildDecryptedContent(),
            ],
          ],
        ),
      ),
    );
  }
}
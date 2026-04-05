import 'package:flutter/material.dart';
import 'package:winkwink/generated/l10n/app_localizations.dart';

import '../widgets/neon_button.dart';
import '../widgets/ww_dialogs.dart';
import '../services/crypto_service.dart';
import '../models/encrypted_file.dart';

class EncryptPage extends StatefulWidget {
  const EncryptPage({super.key});

  @override
  State<EncryptPage> createState() => _EncryptPageState();
}

class _EncryptPageState extends State<EncryptPage> {
  final _crypto = CryptoService();

  String? _visibleImagePath;
  EncryptedPayloadType? _selectedType;

  Future<void> _pickVisibleImage() async {
    // TODO: integrazione galleria reale
    setState(() {
      _visibleImagePath = '/path/finto/immagine_visibile.png';
    });
  }

  Future<void> _encrypt() async {
    final l10n = AppLocalizations.of(context)!;

    if (_visibleImagePath == null || _selectedType == null) {
      await showInfoDialog(
        context,
        title: l10n.encryptError,
        message: l10n.encryptMissingSelection,
      );
      return;
    }

    final file = await _crypto.encryptPlaceholder(
      visibleImagePath: _visibleImagePath!,
      type: _selectedType!,
    );

    await showInfoDialog(
      context,
      title: l10n.encryptReady,
      message: l10n.encryptReadyMessage,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.encryptTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              l10n.encryptDescription,
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 16),

            NeonButton(
              label: _visibleImagePath == null
                  ? l10n.encryptPickVisible
                  : l10n.encryptVisibleSelected,
              onPressed: _pickVisibleImage,
            ),

            const SizedBox(height: 16),
            Text(l10n.encryptChooseHidden),
            const SizedBox(height: 8),

            RadioListTile<EncryptedPayloadType>(
              title: Text(l10n.encryptHideImage),
              value: EncryptedPayloadType.image,
              groupValue: _selectedType,
              onChanged: (v) => setState(() => _selectedType = v),
            ),
            RadioListTile<EncryptedPayloadType>(
              title: Text(l10n.encryptHideText),
              value: EncryptedPayloadType.text,
              groupValue: _selectedType,
              onChanged: (v) => setState(() => _selectedType = v),
            ),
            RadioListTile<EncryptedPayloadType>(
              title: Text(l10n.encryptHideAudio),
              value: EncryptedPayloadType.audio,
              groupValue: _selectedType,
              onChanged: (v) => setState(() => _selectedType = v),
            ),

            const SizedBox(height: 24),

            NeonButton(
              label: l10n.encryptButton,
              onPressed: _encrypt,
            ),
          ],
        ),
      ),
    );
  }
}
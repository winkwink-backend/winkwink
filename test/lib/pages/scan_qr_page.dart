import 'package:flutter/material.dart';
import 'package:winkwink/generated/l10n/app_localizations.dart';

import '../widgets/neon_button.dart';
import '../widgets/ww_dialogs.dart';

class ScanQrPage extends StatelessWidget {
  const ScanQrPage({super.key});

  Future<void> _scanFromGallery(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;

    await showInfoDialog(
      context,
      title: l10n.scanQrPlaceholderTitle,
      message: l10n.scanQrPlaceholderMessage,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.scanQrTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              l10n.scanQrDescription,
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 24),
            NeonButton(
              label: l10n.scanQrButton,
              onPressed: () => _scanFromGallery(context),
            ),
          ],
        ),
      ),
    );
  }
}
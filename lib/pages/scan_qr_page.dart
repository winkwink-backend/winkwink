import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winkwink/generated/l10n/app_localizations.dart';

import '../widgets/mini_neon_button.dart';
import '../widgets/ww_dialogs.dart';
import '../widgets/winkwink_scaffold.dart';
import '../providers/color_provider.dart';

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
    final theme = Provider.of<ColorProvider>(context);

    return WinkWinkScaffold(
      showColorSelector: false,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const SizedBox(height: 10),

            // 🔥 TITOLO
            Text(
              l10n.scanQrTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: theme.text,
              ),
            ),

            const SizedBox(height: 12),

            // DESCRIZIONE
            Text(
              l10n.scanQrDescription,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 24),

            // 🔘 MINI NEON BUTTON — SCANSIONE DA GALLERIA
            MiniNeonButton(
              icon: Icons.qr_code_scanner,
              label: l10n.scanQrButton,
              onPressed: () => _scanFromGallery(context),
            ),
          ],
        ),
      ),
    );
  }
}

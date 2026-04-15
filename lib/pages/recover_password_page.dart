import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winkwink/generated/l10n.dart';

import '../services/storage_service.dart';
import '../routes.dart';
import '../widgets/winkwink_scaffold.dart';
import '../providers/color_provider.dart';

class RecoverPasswordPage extends StatelessWidget {
  const RecoverPasswordPage({super.key});

  Future<void> _resetApp(BuildContext context) async {
    final l10n = S.of(context)!;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          l10n.resetAppTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(l10n.resetAppMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancelButton),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              l10n.resetButton,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    // 🔥 Cancella TUTTI i dati locali
    await StorageService.clearAll();

    // 🔥 Torna alla LoginPage
    if (!context.mounted) return;
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;
    final theme = Provider.of<ColorProvider>(context);

    return WinkWinkScaffold(
      showColorSelector: false,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🔥 TITOLO NEON
            Text(
              l10n.recoverPasswordTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: theme.text,
                shadows: const [
                  Shadow(
                    blurRadius: 4,
                    color: Colors.black,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🔥 DESCRIZIONE MULTILINGUA
            Text(
              l10n.recoverPasswordDescription,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 40),

            // 🔥 PULSANTE RESET IN STILE WINKWINK
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 4,
              ),
              onPressed: () => _resetApp(context),
              child: Text(
                l10n.resetAppButton,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

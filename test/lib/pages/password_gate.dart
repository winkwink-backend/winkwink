import 'package:flutter/material.dart';
import 'package:winkwink/generated/l10n/app_localizations.dart';

import '../services/storage_service.dart';
import '../routes.dart';
import '../widgets/neon_button.dart';

class PasswordGatePage extends StatefulWidget {
  const PasswordGatePage({super.key});

  @override
  State<PasswordGatePage> createState() => _PasswordGatePageState();
}

class _PasswordGatePageState extends State<PasswordGatePage> {
  final _passwordCtrl = TextEditingController();
  String? _error;

  Future<void> _checkPassword() async {
    final l10n = AppLocalizations.of(context)!;

    final saved = await StorageService.getPassword();

    if (!mounted) return;

    if (saved == null) {
      setState(() => _error = l10n.noPasswordSaved);
      return;
    }

    if (_passwordCtrl.text.trim() != saved) {
      setState(() => _error = l10n.wrongPassword);
      return;
    }

    Navigator.of(context).pushReplacementNamed(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.passwordGateTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              l10n.passwordGateDescription,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            TextField(
              controller: _passwordCtrl,
              obscureText: true,
              decoration: InputDecoration(
                labelText: l10n.passwordLabelShort,
                errorText: _error,
              ),
            ),

            const SizedBox(height: 24),

            NeonButton(
              label: l10n.accessButton,
              onPressed: _checkPassword,
            ),
          ],
        ),
      ),
    );
  }
}
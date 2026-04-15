import 'package:flutter/material.dart';
import 'package:winkwink/generated/l10n.dart';

import '../services/storage_service.dart';
import '../routes.dart';
import '../widgets/neon_button.dart';
import '../widgets/winkwink_scaffold.dart';

class PasswordGatePage extends StatefulWidget {
  const PasswordGatePage({super.key});

  @override
  State<PasswordGatePage> createState() => _PasswordGatePageState();
}

class _PasswordGatePageState extends State<PasswordGatePage> {
  final _passwordCtrl = TextEditingController();
  String? _error;

  Future<void> _checkPassword() async {
    final l10n = S.of(context)!;

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
    final l10n = S.of(context)!;

    return WinkWinkScaffold(
      appBar: AppBar(
        title: Text(
          l10n.passwordGateTitle,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black.withOpacity(0.4),
        elevation: 0,
      ),
      showColorSelector: false,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            Text(
              l10n.passwordGateDescription,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 32),

            // 🔥 Campo password rettangolare
            TextField(
              controller: _passwordCtrl,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.30),
                labelText: l10n.passwordLabelShort,
                labelStyle: const TextStyle(color: Colors.white70),
                errorText: _error,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 32),

            NeonButton(
              label: l10n.accessButton,
              onPressed: _checkPassword,
            ),

            const SizedBox(height: 24),

            // 🔥 Link recupero password
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.passwordResetRequest);
              },
              child: Text(
                l10n.forgotPassword,
                style: const TextStyle(
                  color: Colors.white70,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

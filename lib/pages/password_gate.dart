import 'package:flutter/material.dart';
import 'package:winkwink/generated/l10n/app_localizations.dart';

import '../widgets/winkwink_scaffold.dart';
import '../services/storage_service.dart';
import '../routes.dart';

class PasswordGatePage extends StatefulWidget {
  const PasswordGatePage({super.key});

  @override
  State<PasswordGatePage> createState() => _PasswordGatePageState();
}

class _PasswordGatePageState extends State<PasswordGatePage> {
  final TextEditingController _passwordController = TextEditingController();
  bool _wrongPassword = false;

  // ⭐ NUOVO: mostra/nascondi password
  bool _obscurePassword = true;

  Future<void> _checkPassword() async {
    final savedPassword = await StorageService.getPassword();
    if (_passwordController.text == savedPassword) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.home);
    } else {
      setState(() {
        _wrongPassword = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return WinkWinkScaffold(
      showColorSelector: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔥 TITOLO
            Text(
              l10n.passwordGateTitle,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 4,
                    color: Colors.black87,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // 🔥 SOTTOTITOLO
            Text(
              l10n.passwordGateDescription,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 30),

            // 🔥 CAMPO PASSWORD CON OCCHIO
            TextField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintText: l10n.passwordLabelShort,
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 18,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                filled: true,
                fillColor: Colors.black.withOpacity(0.35),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: Colors.white.withOpacity(0.4),
                    width: 1.2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: Colors.white.withOpacity(0.3),
                    width: 1.2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 1.4,
                  ),
                ),

                // ⭐ AGGIUNTA: icona occhio
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white.withOpacity(0.8),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 14),

            if (_wrongPassword)
              Text(
                l10n.wrongPassword,
                style: const TextStyle(
                  color: Colors.redAccent,
                  fontSize: 16,
                ),
              ),

            const SizedBox(height: 40),

            // 🔘 BOTTONE ACCEDI
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: _checkPassword,
                child: Text(
                  l10n.accessButton,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

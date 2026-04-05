import 'package:flutter/material.dart';
import 'package:winkwink/generated/l10n/app_localizations.dart';

import '../services/storage_service.dart';
import '../routes.dart';

class StartupPage extends StatefulWidget {
  const StartupPage({super.key});

  @override
  State<StartupPage> createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    final email = await StorageService.getEmail();
    final hasPassword = await StorageService.getHasPassword();

    // Dopo async gap → controllo sicurezza
    if (!mounted) return;

    if (email == null || email.trim().isEmpty) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.login);
      return;
    }

    if (hasPassword == true) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.passwordGate);
      return;
    }

    Navigator.of(context).pushReplacementNamed(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              l10n.startupLoading,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
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
    _checkStartupFlow();
  }

  Future<void> _checkStartupFlow() async {
    final isRegistered = await StorageService.isRegistered();
    final hasPassword = await StorageService.getHasPassword();

    if (!mounted) return;

    // 🔥 Primo avvio → Login
    if (!isRegistered) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.login);
      return;
    }

    // 🔥 Utente registrato → deve passare dal PasswordGate
    if (hasPassword) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.passwordGate);
      return;
    }

    // 🔥 Caso finale → Home
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
import 'package:flutter/material.dart';
import 'package:winkwink/generated/l10n.dart';

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
    // ⭐ 1) L’utente ha fatto login?
    final loggedIn = await StorageService.isLoggedIn();

    if (!loggedIn) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.login);
      return;
    }

    // ⭐ 2) L’utente ha una password?
    final hasPassword = await StorageService.getHasPassword();

    if (!hasPassword) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.passwordGate);
      return;
    }

    // ⭐ 3) Ha un profilo valido?
    final profile = await StorageService.getProfile();
    final email = profile["email"];
    final password = profile["password"];

    if (email == null || password == null) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.login);
      return;
    }

    // ⭐ 4) Ha un userId?
    final userId = await StorageService.getUserId();
    if (userId == null) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.login);
      return;
    }

    // ⭐ Tutto ok → Home
    Navigator.of(context).pushReplacementNamed(AppRoutes.passwordGate);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;

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

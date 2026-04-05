import 'package:flutter/material.dart';
import 'package:winkwink/generated/l10n/app_localizations.dart';

import '../widgets/neon_button.dart';
import '../routes.dart';
import '../services/storage_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _hasPassword = false;

  @override
  void initState() {
    super.initState();
    _loadPasswordFlag();
  }

  Future<void> _loadPasswordFlag() async {
    final flag = await StorageService.getHasPassword();
    setState(() {
      _hasPassword = flag;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [

            // 🔥 MOSTRA IL PULSANTE LOGIN SOLO SE NON ESISTE PASSWORD
            if (!_hasPassword)
              NeonButton(
                label: l10n.loginButton,
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.login);
                },
              ),

            const SizedBox(height: 16),

            NeonButton(
              label: l10n.sendQrButton,
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.sendQr);
              },
            ),

            const SizedBox(height: 16),

            NeonButton(
              label: l10n.encryptButtonHome,
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.encrypt);
              },
            ),

            const SizedBox(height: 16),

            NeonButton(
              label: l10n.decryptButtonHome,
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.decrypt);
              },
            ),

            const SizedBox(height: 16),

            NeonButton(
              label: l10n.galleryButton,
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.gallery);
              },
            ),

            const SizedBox(height: 16),

            NeonButton(
              label: l10n.scanQrButton,
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.scanQr);
              },
            ),

            const SizedBox(height: 16),

            NeonButton(
              label: l10n.contactsButton,
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.contacts);
              },
            ),

            const SizedBox(height: 16),

            NeonButton(
              label: l10n.passepartoutButton,
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.passepartout);
              },
            ),

            const SizedBox(height: 16),

            NeonButton(
              label: l10n.faqButton,
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.faq);
              },
            ),
          ],
        ),
      ),
    );
  }
}
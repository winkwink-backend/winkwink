import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winkwink/generated/l10n/app_localizations.dart';

import '../widgets/mini_neon_button.dart';
import '../widgets/winkwink_scaffold.dart';
import '../routes.dart';
import '../services/storage_service.dart';
import '../providers/color_provider.dart';

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

    return WinkWinkScaffold(
      showColorSelector: true, // Pallini solo in Home

      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 16),
          MiniNeonButton(
            label: l10n.sendQrButton,
            icon: Icons.qr_code_2,
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.sendQr);
            },
          ),
          MiniNeonButton(
            label: l10n.encryptButtonHome,
            icon: Icons.lock,
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.encrypt);
            },
          ),
          MiniNeonButton(
            label: l10n.decryptButtonHome,
            icon: Icons.lock_open,
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.decrypt);
            },
          ),
          MiniNeonButton(
            label: l10n.galleryButton,
            icon: Icons.image,
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.gallery);
            },
          ),
          MiniNeonButton(
            label: l10n.scanQrButton,
            icon: Icons.qr_code_scanner,
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.scanQr);
            },
          ),
          MiniNeonButton(
            label: l10n.contactsButton,
            icon: Icons.contacts,
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.contacts);
            },
          ),
          MiniNeonButton(
            label: l10n.passepartoutButton,
            icon: Icons.key,
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.passepartout);
            },
          ),
          MiniNeonButton(
            label: l10n.faqButton,
            icon: Icons.help_outline,
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.faq);
            },
          ),
        ],
      ),
    );
  }
}

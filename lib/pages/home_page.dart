import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winkwink/generated/l10n.dart';

import '../widgets/mini_neon_button.dart';
import '../widgets/winkwink_scaffold.dart';
import '../routes.dart';
import '../providers/color_provider.dart';
import '../services/storage_service.dart';

class HomePage extends StatelessWidget {
  final int? userId;

  const HomePage({super.key, this.userId});

  Future<void> _logout(BuildContext context) async {
    await StorageService.setLoggedIn(false);
    Navigator.of(context).pushReplacementNamed(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final colors = Provider.of<ColorProvider>(context);

    return WinkWinkScaffold(
      userId: userId,
      showColorSelector: true,

      // ⭐ CONTENUTO PRINCIPALE
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MiniNeonButton(
                label: l10n.sendQrButton,
                icon: Icons.qr_code_2,
                onPressed: () => Navigator.pushNamed(context, AppRoutes.sendQr),
              ),
              MiniNeonButton(
                label: l10n.encryptButtonHome,
                icon: Icons.lock,
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.encrypt),
              ),
              MiniNeonButton(
                label: l10n.decryptButtonHome,
                icon: Icons.lock_open,
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.decrypt),
              ),
              MiniNeonButton(
                label: "Video WW",
                icon: Icons.video_collection,
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.videoWW),
              ),
              MiniNeonButton(
                label: l10n.scanQrButton,
                icon: Icons.qr_code_scanner,
                onPressed: () => Navigator.pushNamed(context, AppRoutes.scanQr),
              ),
              MiniNeonButton(
                label: l10n.passepartoutButton,
                icon: Icons.key,
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.passepartout),
              ),
              MiniNeonButton(
                label: l10n.faqButton,
                icon: Icons.help_outline,
                onPressed: () => Navigator.pushNamed(context, AppRoutes.faq),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

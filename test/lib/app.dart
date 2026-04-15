import 'package:flutter/material.dart';
import '../../lib/generated/app_localizations.dart';
import 'routes.dart';

class WinkWinkApp extends StatelessWidget {
  const WinkWinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // 🌍 Localizzazione
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      // 🌍 Titolo multilingua
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,

      // Rotte
      initialRoute: AppRoutes.startup,
      routes: AppRoutes.routes,
    );
  }
}

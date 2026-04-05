import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winkwink/generated/l10n/app_localizations.dart';

import 'providers/color_provider.dart';
import 'routes.dart'; // 👈 Cambiato da routes/app_routes.dart a routes.dart

class WinkWinkApp extends StatelessWidget {
  const WinkWinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ColorProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      // Usa solo 'theme'. Se hai 'darkTheme', Flutter lo userà ignorando le tue impostazioni.
      theme: ThemeData(
        useMaterial3: true,
        
        // Forza la trasparenza su tutti i widget di base
        scaffoldBackgroundColor: Colors.transparent,
        canvasColor: Colors.transparent,
        cardColor: Colors.transparent,

        colorScheme: ColorScheme.fromSeed(
          // Assicurati che nel tuo ColorProvider il campo si chiami 'primary'
          seedColor: themeProvider.primary, 
          brightness: Brightness.dark,
          surface: Colors.transparent, // "Buca" il nero dei widget Material
          onSurface: themeProvider.text,
        ),

        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: themeProvider.text,
          elevation: 0,
          centerTitle: true,
        ),
      ),

      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      
      // Gestione sicura del titolo per evitare l'errore Null Check
      onGenerateTitle: (context) => AppLocalizations.of(context)?.appTitle ?? "WinkWink",

      // Usa i nomi corretti definiti nel tuo lib/routes.dart
      initialRoute: AppRoutes.startup,
      routes: AppRoutes.routes,
    );
  }
}
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winkwink/generated/l10n.dart';

import 'providers/color_provider.dart';
import 'routes.dart';
import 'l10n/legal/legal_localizations.dart';

class WinkWinkApp extends StatelessWidget {
  const WinkWinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ColorProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.transparent,
        canvasColor: Colors.transparent,
        cardColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(
          seedColor: themeProvider.primary,
          brightness: Brightness.dark,
          surface: Colors.transparent,
          onSurface: themeProvider.text,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: themeProvider.text,
          elevation: 0,
          centerTitle: true,
        ),
      ),

      localizationsDelegates: [
        S.delegate,
        LegalLocalizations.delegate, // <--- IL TUO DELEGATE È QUESTO
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('it'),
        Locale('en'),
      ],

      // ⭐ CORRETTO
      initialRoute: AppRoutes.startup,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}

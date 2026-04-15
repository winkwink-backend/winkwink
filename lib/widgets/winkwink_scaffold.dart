import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winkwink/generated/l10n.dart';

import '../providers/color_provider.dart';
import '../routes.dart';

/// MODELLO COLORE
class ThemeColorOption {
  final Color background;
  final Color text;
  final Color primary;

  const ThemeColorOption({
    required this.background,
    required this.text,
    required this.primary,
  });
}

class WinkWinkScaffold extends StatelessWidget {
  final Widget child;
  final bool showColorSelector;

  /// userId passato dalla HomePage
  final int? userId;

  /// supporto appBar
  final PreferredSizeWidget? appBar;

  /// supporto FAB
  final Widget? customHeader;
  final Widget? floatingActionButton;

  WinkWinkScaffold({
    super.key,
    required this.child,
    this.showColorSelector = false,
    this.userId,
    this.appBar,
    this.floatingActionButton,
    this.customHeader,
  });

  // PALETTE COLORE DISPONIBILE
  final List<ThemeColorOption> colorOptions = const [
    ThemeColorOption(
      background: Colors.black,
      text: Colors.white,
      primary: Colors.blueAccent,
    ),
    ThemeColorOption(
      background: Color(0xFF786D46),
      text: Color.fromARGB(255, 13, 13, 13),
      primary: Colors.cyanAccent,
    ),
    ThemeColorOption(
      background: Color(0xFFFFAB94),
      text: Colors.black,
      primary: Colors.blue,
    ),
    ThemeColorOption(
      background: Color(0xFFFFDCD3),
      text: Color.fromARGB(255, 28, 27, 27),
      primary: Colors.pinkAccent,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final theme = Provider.of<ColorProvider>(context);

    if (l10n == null) return const SizedBox.shrink();

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      body: Stack(
        children: [
          // SFONDO
          Positioned.fill(
            child: Image.asset(
              "assets/icon/SFONDO_winkwink.png",
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: Colors.black),
            ),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (customHeader != null) customHeader!,

                // ⭐ HEADER COMPLETO: LOGO + SOTTOTITOLO + ICONE ⭐
                if (appBar == null)
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 12, left: 12, right: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // LOGO + SOTTOTITOLO
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/icon/marchiologo_winkwink1.png",
                              height: 48,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              l10n.winkwinkSubtitle,
                              style: const TextStyle(
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    blurRadius: 3,
                                    color: Colors.black,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        // ICONE A DESTRA
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.chat_bubble_outline,
                                  color: Colors.white),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.chat,
                                  arguments: {
                                    "userId": userId ?? 0,
                                    "otherId": 0,
                                    "name": "Chat",
                                  },
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.notifications_none,
                                  color: Colors.white),
                              onPressed: () {
                                Navigator.pushNamed(context, AppRoutes.inbox);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.people_alt,
                                  color: Colors.white),
                              onPressed: () => Navigator.pushNamed(
                                  context, AppRoutes.contacts),
                            ),
                            IconButton(
                              icon: const Icon(Icons.settings,
                                  color: Colors.white),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.settings);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 16),

                // CONTENUTO
                Expanded(
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      scaffoldBackgroundColor: Colors.transparent,
                      canvasColor: Colors.transparent,
                      cardColor: Colors.transparent,
                    ),
                    child: DefaultTextStyle(
                      style: TextStyle(color: theme.text),
                      child: child,
                    ),
                  ),
                ),

                // SELETTORE COLORE
                if (showColorSelector)
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 20, left: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            _buildColorDot(context, colorOptions[0]),
                            const SizedBox(width: 12),
                            _buildColorDot(context, colorOptions[1]),
                          ],
                        ),
                        Row(
                          children: [
                            _buildColorDot(context, colorOptions[2]),
                            const SizedBox(width: 12),
                            _buildColorDot(context, colorOptions[3]),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorDot(BuildContext context, ThemeColorOption option) {
    final theme = Provider.of<ColorProvider>(context, listen: false);
    final isSelected = option.background == theme.background;

    return GestureDetector(
      onTap: () {
        theme.setTheme(option.background, option.text, option.primary);
      },
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          color: option.background,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }
}

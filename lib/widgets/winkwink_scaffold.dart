import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winkwink/generated/l10n/app_localizations.dart';

import '../providers/color_provider.dart';

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

  WinkWinkScaffold({
    super.key,
    required this.child,
    this.showColorSelector = false,
  });

  // PALETTE COLORE DISPONIBILE
  final List<ThemeColorOption> colorOptions = const [
    ThemeColorOption(
      background: Colors.black,
      text: Colors.white,
      primary: Colors.blueAccent,
    ),
    ThemeColorOption(
      background: Color(0xFF4A4A4A),
      text: Colors.white,
      primary: Colors.cyanAccent,
    ),
    ThemeColorOption(
      background: Color(0xFF4FC3F7),
      text: Colors.black,
      primary: Colors.blue,
    ),
    ThemeColorOption(
      background: Color(0xFFFF4FA7),
      text: Colors.white,
      primary: Colors.pinkAccent,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Provider.of<ColorProvider>(context);

    if (l10n == null) return const SizedBox.shrink();

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
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
                // HEADER (logo + sottotitolo)
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/icon/marchiologo_winkwink1.png",
                        height: 60,
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

                // ⭐ NUOVO SELETTORE COLORE (2 pallini sinistra + 2 destra)
                if (showColorSelector)
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 20, left: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 🔵🔴 lato sinistro
                        Row(
                          children: [
                            _buildColorDot(context, colorOptions[0]),
                            const SizedBox(width: 12),
                            _buildColorDot(context, colorOptions[1]),
                          ],
                        ),

                        // 🟢🟣 lato destro
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/color_provider.dart';

class MiniNeonButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const MiniNeonButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ColorProvider>(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 54, // ⭐ più alto per pulsanti Home
      decoration: BoxDecoration(
        color: theme.background.withOpacity(0.9), // ⭐ più elegante
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: theme.text.withOpacity(0.35),
          width: 1.2,
        ),
        boxShadow: [
          // ⭐ Effetto neon leggero
          BoxShadow(
            color: theme.text.withOpacity(0.25),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: theme.text,
              size: 22, // ⭐ leggermente più grande
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: theme.text,
                  fontSize: 16, // ⭐ più leggibile
                  fontWeight: FontWeight.w600,
                  shadows: [
                    Shadow(
                      blurRadius: 4,
                      color: theme.text.withOpacity(0.4),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

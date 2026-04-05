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
      margin: const EdgeInsets.symmetric(vertical: 6),
      height: 48,
      decoration: BoxDecoration(
        color: theme.background, // ⭐ colore dinamico
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.text.withOpacity(0.3), // ⭐ bordo dinamico
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: theme.text, size: 20), // ⭐ icona dinamica
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: theme.text, // ⭐ testo dinamico
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

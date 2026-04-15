import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/color_provider.dart';

class NeonButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed; // ✔ ora nullable
  final IconData? icon;

  const NeonButton({
    super.key,
    required this.label,
    this.onPressed, // ✔ non required
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ColorProvider>(context);

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: theme.background.withOpacity(0.6),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.background,
          foregroundColor: theme.text,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: onPressed, // ✔ accetta null
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: theme.text, size: 22),
              const SizedBox(width: 10),
            ],
            Text(
              label,
              style: TextStyle(
                color: theme.text,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/winkwink_scaffold.dart';
import '../../widgets/mini_neon_button.dart';
import '../../providers/color_provider.dart';
import 'package:winkwink/generated/l10n.dart';

class TextSecretPage extends StatefulWidget {
  final String mode; // ⭐ encrypt o sandwich

  const TextSecretPage({super.key, this.mode = "encrypt"});

  @override
  State<TextSecretPage> createState() => _TextSecretPageState();
}

class _TextSecretPageState extends State<TextSecretPage> {
  final TextEditingController _controller = TextEditingController();

  String mode = "encrypt"; // ⭐ modalità attuale

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map && args["mode"] == "sandwich") {
      mode = "sandwich";
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;
    final theme = Provider.of<ColorProvider>(context);

    return WinkWinkScaffold(
      showColorSelector: false,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ⭐ FRECCIA BACK SEMPRE NERA
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              iconSize: 36,
              icon: const Icon(Icons.keyboard_double_arrow_left),
              color: Colors.black,
              onPressed: () => Navigator.pop(context),
            ),
          ),

          const SizedBox(height: 10),

          // 🔥 TITOLO
          Text(
            l10n.textSecretTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 10),

          // 🔥 SOTTOTITOLO
          Text(
            l10n.textSecretSubtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 30),

          // 🔥 TEXTFIELD GRANDE STILE NOTA
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.black12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: TextField(
              controller: _controller,
              maxLines: 10,
              minLines: 8,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Scrivi qui il tuo messaggio segreto...",
                hintStyle: TextStyle(
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          // 🔘 CONFERMA
          MiniNeonButton(
            label: l10n.okButton,
            icon: Icons.check,
            onPressed: () {
              final text = _controller.text.trim();
              if (text.isEmpty) return;

              Navigator.pop(context, {
                "type": "text",
                "payload": text, // ⭐ compatibile con Sandwich
              });
            },
          ),
        ],
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../widgets/winkwink_scaffold.dart';
import '../../widgets/mini_neon_button.dart';
import '../../providers/color_provider.dart';
import 'package:winkwink/generated/l10n/app_localizations.dart';

class HideImageSecretPage extends StatefulWidget {
  const HideImageSecretPage({super.key});

  @override
  State<HideImageSecretPage> createState() => _HideImageSecretPageState();
}

class _HideImageSecretPageState extends State<HideImageSecretPage> {
  final ImagePicker _picker = ImagePicker();
  File? hiddenImage;

  Future<void> pickHiddenImage() async {
    final XFile? img = await _picker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      setState(() {
        hiddenImage = File(img.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
              color: Colors.black, // ← sempre nera
              onPressed: () => Navigator.pop(context),
            ),
          ),

          const SizedBox(height: 10),

          // 🔥 TITOLO
          Text(
            l10n.hideImageTitle,
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
            l10n.hideImageSubtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 30),

          // 🔘 PULSANTE PER SCEGLIERE L'IMMAGINE
          MiniNeonButton(
            label: l10n.visible_image_button,
            icon: Icons.image,
            onPressed: pickHiddenImage,
          ),

          if (hiddenImage != null) ...[
            const SizedBox(height: 20),

            // 🔥 MINIATURA PICCOLA (120x120)
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  hiddenImage!,
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // 🔘 CONFERMA
            MiniNeonButton(
              label: l10n.okButton,
              icon: Icons.check,
              onPressed: () {
                Navigator.pop(context, {
                  "type": "image",
                  "file": hiddenImage,
                });
              },
            ),
          ],
        ],
      ),
    );
  }
}

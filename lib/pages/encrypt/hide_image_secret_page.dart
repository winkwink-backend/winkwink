import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:provider/provider.dart';

import '../../widgets/winkwink_scaffold.dart';
import '../../providers/color_provider.dart';
import '../../widgets/mini_neon_button.dart';
import 'package:winkwink/generated/l10n/app_localizations.dart';

class HideImageSecretPage extends StatefulWidget {
  final String mode; // ⭐ encrypt o sandwich

  const HideImageSecretPage({super.key, this.mode = "encrypt"});

  @override
  State<HideImageSecretPage> createState() => _HideImageSecretPageState();
}

class _HideImageSecretPageState extends State<HideImageSecretPage> {
  final ImagePicker _picker = ImagePicker();
  File? hiddenImage;

  String mode = "encrypt"; // ⭐ modalità attuale

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map && args["mode"] == "sandwich") {
      mode = "sandwich";
    }
  }

  // ⭐ Compressione intelligente usando il pacchetto "image"
  Future<File> compressIfNeeded(File file) async {
    const int maxSize = 2 * 1024 * 1024; // 2 MB
    final int fileSize = await file.length();

    if (fileSize <= maxSize) {
      return file; // troppo piccola → non serve comprimere
    }

    final Uint8List bytes = await file.readAsBytes();
    final img.Image? decoded = img.decodeImage(bytes);

    if (decoded == null) return file;

    final img.Image resized = img.copyResize(
      decoded,
      width: 1920,
      height: 1080,
      interpolation: img.Interpolation.average,
    );

    final List<int> compressedBytes = img.encodeJpg(
      resized,
      quality: 80,
    );

    final String newPath = file.path.replaceAll(".jpg", "_compressed.jpg");
    final File compressedFile = File(newPath);

    await compressedFile.writeAsBytes(compressedBytes);

    return compressedFile;
  }

  // ⭐ Seleziona immagine + compressione automatica
  Future<void> pickHiddenImage() async {
    final XFile? imgFile = await _picker.pickImage(source: ImageSource.gallery);
    if (imgFile != null) {
      File original = File(imgFile.path);
      File optimized = await compressIfNeeded(original);

      setState(() {
        hiddenImage = optimized;
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
              color: Colors.black,
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
                if (hiddenImage == null) return;

                Navigator.pop(context, {
                  "type": "image",
                  "payload": hiddenImage, // ⭐ compatibile con Sandwich
                });
              },
            ),
          ],
        ],
      ),
    );
  }
}

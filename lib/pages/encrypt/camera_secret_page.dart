import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:provider/provider.dart';
import 'package:winkwink/generated/l10n/app_localizations.dart';

import '../../widgets/winkwink_scaffold.dart';
import '../../providers/color_provider.dart';
import '../../widgets/mini_neon_button.dart';

class CameraSecretPage extends StatefulWidget {
  const CameraSecretPage({super.key});

  @override
  State<CameraSecretPage> createState() => _CameraSecretPageState();
}

class _CameraSecretPageState extends State<CameraSecretPage> {
  final ImagePicker _picker = ImagePicker();
  File? capturedImage;

  // ⭐ Compressione intelligente usando il pacchetto "image"
  Future<File> compressIfNeeded(File file) async {
    const int maxSize = 2 * 1024 * 1024; // 2 MB
    final int fileSize = await file.length();

    if (fileSize <= maxSize) {
      return file; // troppo piccola → non serve comprimere
    }

    // Leggi i bytes
    final Uint8List bytes = await file.readAsBytes();
    final img.Image? decoded = img.decodeImage(bytes);

    if (decoded == null) return file;

    // Ridimensionamento per tablet (1080p)
    final img.Image resized = img.copyResize(
      decoded,
      width: 1920,
      height: 1080,
      interpolation: img.Interpolation.average,
    );

    // Ricompressione JPEG qualità 80
    final List<int> compressedBytes = img.encodeJpg(
      resized,
      quality: 80,
    );

    final String newPath = file.path.replaceAll(".jpg", "_compressed.jpg");
    final File compressedFile = File(newPath);

    await compressedFile.writeAsBytes(compressedBytes);

    return compressedFile;
  }

  // ⭐ Scatta foto + compressione automatica
  Future<void> takePhoto() async {
    final XFile? imgFile = await _picker.pickImage(source: ImageSource.camera);
    if (imgFile != null) {
      File original = File(imgFile.path);
      File optimized = await compressIfNeeded(original);

      setState(() {
        capturedImage = optimized;
      });
    }
  }

  void deletePhoto() {
    setState(() {
      capturedImage = null;
    });
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
          Text(
            l10n.cameraSecretTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            l10n.cameraSecretSubtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 30),
          MiniNeonButton(
            label: l10n.encryptTakePhoto,
            icon: Icons.photo_camera,
            onPressed: takePhoto,
          ),
          if (capturedImage != null) ...[
            const SizedBox(height: 20),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  capturedImage!,
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: IconButton(
                iconSize: 32,
                color: Colors.red.shade700,
                icon: const Icon(Icons.delete),
                onPressed: deletePhoto,
              ),
            ),
            const SizedBox(height: 20),
            MiniNeonButton(
              label: l10n.okButton,
              icon: Icons.check,
              onPressed: () {
                if (capturedImage == null) return;
                Navigator.pop(context, {
                  "type": "camera",
                  "file": capturedImage,
                });
              },
            ),
          ],
        ],
      ),
    );
  }
}

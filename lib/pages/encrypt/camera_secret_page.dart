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
  final String mode; // encrypt o sandwich

  const CameraSecretPage({super.key, this.mode = "encrypt"});

  @override
  State<CameraSecretPage> createState() => _CameraSecretPageState();
}

class _CameraSecretPageState extends State<CameraSecretPage> {
  final ImagePicker _picker = ImagePicker();
  File? capturedImage;

  bool isCompressing = false;
  double compressProgress = 0.0;
  bool compressionRunning = false;

  String mode = "encrypt";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map && args["mode"] == "sandwich") {
      mode = "sandwich";
    }
  }

  // ⭐ Compressione intelligente con overlay
  Future<File> compressIfNeeded(File file) async {
    const int maxSize = 2 * 1024 * 1024; // 2 MB
    final int fileSize = await file.length();

    if (fileSize <= maxSize) {
      return file;
    }

    if (compressionRunning) return file;

    setState(() {
      isCompressing = true;
      compressProgress = 0.0;
      compressionRunning = true;
    });

    try {
      final Uint8List bytes = await file.readAsBytes();
      final img.Image? decoded = img.decodeImage(bytes);

      if (decoded == null) {
        return file;
      }

      // Ridimensionamento
      final img.Image resized = img.copyResize(
        decoded,
        width: 1920,
        height: 1080,
        interpolation: img.Interpolation.average,
      );

      // Simulazione avanzamento (smooth)
      for (int i = 0; i <= 100; i += 8) {
        await Future.delayed(const Duration(milliseconds: 30));
        if (mounted) {
          setState(() => compressProgress = i.toDouble());
        }
      }

      final List<int> compressedBytes = img.encodeJpg(
        resized,
        quality: 80,
      );

      final String newPath = file.path.replaceAll(".jpg", "_compressed.jpg");
      final File compressedFile = File(newPath);

      await compressedFile.writeAsBytes(compressedBytes);

      return compressedFile;
    } finally {
      if (mounted) {
        setState(() {
          isCompressing = false;
          compressionRunning = false;
        });
      }
    }
  }

  // ⭐ Scatta foto + compressione
  Future<void> takePhoto() async {
    if (compressionRunning) return;

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
      child: Stack(
        children: [
          ListView(
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
                      "payload": capturedImage,
                    });
                  },
                ),
              ],
            ],
          ),

          // ⭐ OVERLAY BLOCCANTE DURANTE COMPRESSIONE
          if (isCompressing)
            Container(
              color: Colors.black.withOpacity(0.45),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(color: Colors.white),
                    const SizedBox(height: 20),
                    const Text(
                      "Elaborazione foto…",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        value: compressProgress / 100,
                        minHeight: 8,
                        color: Colors.white,
                        backgroundColor: Colors.white24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../widgets/winkwink_scaffold.dart';
import '../../widgets/mini_neon_button.dart';
import '../../providers/color_provider.dart';
import 'package:winkwink/generated/l10n/app_localizations.dart';

class CameraSecretPage extends StatefulWidget {
  const CameraSecretPage({super.key});

  @override
  State<CameraSecretPage> createState() => _CameraSecretPageState();
}

class _CameraSecretPageState extends State<CameraSecretPage> {
  final ImagePicker _picker = ImagePicker();
  File? capturedImage;

  Future<void> takePhoto() async {
    final XFile? img = await _picker.pickImage(source: ImageSource.camera);
    if (img != null) {
      setState(() {
        capturedImage = File(img.path);
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

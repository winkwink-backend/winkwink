import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:provider/provider.dart';
import 'package:winkwink/generated/l10n/app_localizations.dart';

import '../widgets/mini_neon_button.dart';
import '../widgets/ww_dialogs.dart';
import '../widgets/winkwink_scaffold.dart';
import '../providers/color_provider.dart';

class ScanQrPage extends StatefulWidget {
  const ScanQrPage({super.key});

  @override
  State<ScanQrPage> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  final ImagePicker _picker = ImagePicker();
  CameraController? _cameraController;
  bool _isScanning = false;

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  // ------------------------------------------------------------
  // 1) SCANSIONE DA GALLERIA
  // ------------------------------------------------------------
  Future<void> _scanFromGallery(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;

    try {
      final XFile? img = await _picker.pickImage(source: ImageSource.gallery);
      if (img == null) return;

      final file = File(img.path);
      final inputImage = InputImage.fromFile(file);

      final barcodeScanner = BarcodeScanner(formats: [BarcodeFormat.qrCode]);
      final barcodes = await barcodeScanner.processImage(inputImage);

      if (barcodes.isEmpty) {
        await showInfoDialog(context,
            title: l10n.errorTitle, message: l10n.invalidQr);
        return;
      }

      final qrData = barcodes.first.rawValue;
      _handleQrData(context, qrData);
    } catch (e) {
      await showInfoDialog(context, title: "Errore", message: e.toString());
    }
  }

  // ------------------------------------------------------------
  // 2) SCANSIONE LIVE DA FOTOCAMERA
  // ------------------------------------------------------------
  Future<void> _scanFromCamera(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;

    try {
      final cameras = await availableCameras();
      final camera = cameras.first;

      _cameraController = CameraController(camera, ResolutionPreset.medium);
      await _cameraController!.initialize();

      setState(() {});

      final barcodeScanner = BarcodeScanner(formats: [BarcodeFormat.qrCode]);

      _cameraController!.startImageStream((CameraImage image) async {
        if (_isScanning) return;
        _isScanning = true;

        try {
          final inputImage =
              _convertToInputImage(image, camera.sensorOrientation);
          final barcodes = await barcodeScanner.processImage(inputImage);

          if (barcodes.isNotEmpty) {
            final qrData = barcodes.first.rawValue;
            _cameraController?.stopImageStream();
            _handleQrData(context, qrData);
          }
        } catch (_) {}

        _isScanning = false;
      });
    } catch (e) {
      await showInfoDialog(context, title: "Errore", message: e.toString());
    }
  }

  InputImage _convertToInputImage(CameraImage image, int rotation) {
    final plane = image.planes.first;
    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: InputImageRotationValue.fromRawValue(rotation) ??
            InputImageRotation.rotation0deg,
        format: InputImageFormat.nv21,
        bytesPerRow: plane.bytesPerRow,
      ),
    );
  }

  // ------------------------------------------------------------
  // 3) PARSING QR WINKWINK
  // ------------------------------------------------------------
  void _handleQrData(BuildContext context, String? qrData) async {
    final l10n = AppLocalizations.of(context)!;

    if (qrData == null || !qrData.startsWith("WW|")) {
      await showInfoDialog(context,
          title: l10n.errorTitle, message: l10n.invalidQr);
      return;
    }

    final parts = qrData.split("|");
    if (parts.length != 6) {
      await showInfoDialog(context,
          title: l10n.errorTitle, message: l10n.invalidQr);
      return;
    }

    final contact = {
      "name": "${parts[2]} ${parts[3]}",
      "userId": parts[1],
      "phone": parts[4],
      "publicKey": parts[5],
      "qrData": qrData,
    };

    if (!mounted) return;
    Navigator.pop(context, contact);
  }

  // ------------------------------------------------------------
  // UI
  // ------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Provider.of<ColorProvider>(context);

    return WinkWinkScaffold(
      showColorSelector: false,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const SizedBox(height: 10),

            // 🔥 TITOLO NEON
            Text(
              l10n.scanQrTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: theme.text,
                shadows: const [
                  Shadow(
                    blurRadius: 4,
                    color: Colors.black,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // 🔥 DESCRIZIONE
            Text(
              l10n.scanQrDescription,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),

            const SizedBox(height: 24),

            // 🔥 IMPORTA DA GALLERIA
            MiniNeonButton(
              icon: Icons.photo,
              label: l10n.scanFromGallery,
              onPressed: () => _scanFromGallery(context),
            ),

            const SizedBox(height: 16),

            // 🔥 SCANSIONE LIVE
            MiniNeonButton(
              icon: Icons.camera_alt,
              label: l10n.scanFromCamera,
              onPressed: () => _scanFromCamera(context),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';
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

  Future<void> _scanFromGallery(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;

    try {
      // 1) Scegli immagine
      final XFile? img = await _picker.pickImage(source: ImageSource.gallery);
      if (img == null) return;

      final file = File(img.path);

      // 2) Prepara ML Kit
      final barcodeScanner = BarcodeScanner(
        formats: [BarcodeFormat.qrCode],
      );

      final inputImage = InputImage.fromFile(file);

      // 3) Scansiona
      final barcodes = await barcodeScanner.processImage(inputImage);

      if (barcodes.isEmpty) {
        await showInfoDialog(
          context,
          title: l10n.errorTitle,
          message: l10n.invalidQr,
        );
        return;
      }

      final qrData = barcodes.first.rawValue;

      if (qrData == null || !qrData.startsWith("WW|")) {
        await showInfoDialog(
          context,
          title: l10n.errorTitle,
          message: l10n.invalidQr,
        );
        return;
      }

      // 4) Parsing QR WinkWink
      final parts = qrData.split("|");
      if (parts.length != 6) {
        await showInfoDialog(
          context,
          title: l10n.errorTitle,
          message: l10n.invalidQr,
        );
        return;
      }

      final userId = parts[1];
      final firstName = parts[2];
      final lastName = parts[3];
      final phone = parts[4];
      final publicKey = parts[5];

      final contact = {
        "name": "$firstName $lastName",
        "userId": userId,
        "phone": phone,
        "publicKey": publicKey,
        "qrData": qrData,
      };

      if (!mounted) return;

      Navigator.pop(context, contact);
    } catch (e) {
      await showInfoDialog(
        context,
        title: "Errore",
        message: e.toString(),
      );
    }
  }

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
            Text(
              l10n.scanQrTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: theme.text,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.scanQrDescription,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),
            MiniNeonButton(
              icon: Icons.qr_code_scanner,
              label: l10n.scanQrButton,
              onPressed: () => _scanFromGallery(context),
            ),
          ],
        ),
      ),
    );
  }
}

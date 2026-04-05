import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:winkwink/generated/l10n/app_localizations.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

import '../widgets/neon_button.dart';
import '../services/storage_service.dart';

class SendQrPage extends StatefulWidget {
  const SendQrPage({super.key});

  @override
  State<SendQrPage> createState() => _SendQrPageState();
}

class _SendQrPageState extends State<SendQrPage> {
  String _qrData = 'NESSUN_QR';

  @override
  void initState() {
    super.initState();
    _loadQr();
  }

  Future<void> _loadQr() async {
    final savedQr = await StorageService.getQrData();
    if (!mounted) return;

    setState(() {
      _qrData = savedQr ?? 'NESSUN_QR';
    });
  }

  Future<void> _showError(String message) async {
    final l10n = AppLocalizations.of(context)!;

    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(l10n.errorTitle),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.okButton),
          )
        ],
      ),
    );
  }

  Future<void> _shareQr() async {
    final l10n = AppLocalizations.of(context)!;

    try {
      final qrValidationResult = QrValidator.validate(
        data: _qrData,
        version: QrVersions.auto,
        errorCorrectionLevel: QrErrorCorrectLevel.M,
      );

      if (qrValidationResult.status != QrValidationStatus.valid) {
        return _showError(l10n.invalidQr);
      }

      final qrCode = qrValidationResult.qrCode!;

      final painter = QrPainter.withQr(
        qr: qrCode,
        gapless: true,
        // ⚠️ color & emptyColor deprecati → sostituiti
        eyeStyle: const QrEyeStyle(
          eyeShape: QrEyeShape.square,
          color: Colors.black,
        ),
        dataModuleStyle: const QrDataModuleStyle(
          dataModuleShape: QrDataModuleShape.square,
          color: Colors.black,
        ),
      );

      final ByteData? imageData = await painter.toImageData(220);
      if (!mounted) return;

      if (imageData == null) {
        return _showError(l10n.qrImageError);
      }

      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/winkwink_qr.png');
      await file.writeAsBytes(imageData.buffer.asUint8List());

      await Share.shareXFiles(
        [XFile(file.path)],
        text: l10n.shareQrMessage,
        subject: l10n.shareQrSubject,
      );
    } catch (e) {
      return _showError(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.sendQrTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.sendQrDescription,
              textAlign: TextAlign.start,
            ),

            const SizedBox(height: 24),

            Center(
              child: QrImageView(
                data: _qrData,
                version: QrVersions.auto,
                size: 220,
                backgroundColor: Colors.white,

                // ⚠️ Nuovi parametri consigliati
                eyeStyle: const QrEyeStyle(
                  eyeShape: QrEyeShape.square,
                  color: Colors.black,
                ),
                dataModuleStyle: const QrDataModuleStyle(
                  dataModuleShape: QrDataModuleShape.square,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              '${l10n.internalQrData}\n$_qrData',
              style: const TextStyle(fontSize: 12),
            ),

            const Spacer(),

            NeonButton(
              label: l10n.forwardButton,
              onPressed: _shareQr,
            ),
          ],
        ),
      ),
    );
  }
}
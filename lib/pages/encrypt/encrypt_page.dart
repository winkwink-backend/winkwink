import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:provider/provider.dart';

import 'package:winkwink/generated/l10n.dart';

import '../../widgets/winkwink_scaffold.dart';
import '../../providers/color_provider.dart';
import '../../widgets/mini_neon_button.dart';

import '../../services/storage_service.dart';
import '../../services/ecc_service.dart';
import '../../services/crypto_service.dart';

// ⭐ NUOVO IMPORT
import '../../services/webrtc_manager.dart';
import 'package:winkwink/models/ww_contact.dart';

class EncryptPage extends StatefulWidget {
  const EncryptPage({super.key});

  @override
  State<EncryptPage> createState() => _EncryptPageState();
}

class _EncryptPageState extends State<EncryptPage> {
  List<Map<String, String>> selectedContacts = [];
  final ImagePicker _picker = ImagePicker();

  File? visibleImage;
  Map<String, dynamic>? selectedSecret;

  final ScrollController _scrollController = ScrollController();

  bool showSecretReadyBanner = false;
  bool isProcessing = false;

  // ------------------------------------------------------------
  // ⭐ Calcola capacità immagine
  // ------------------------------------------------------------
  int _estimateCapacity(img.Image image) {
    return (image.width * image.height * 3) ~/ 8;
  }

  // ------------------------------------------------------------
  // ⭐ Interpolazione automatica con limite massimo
  // ------------------------------------------------------------
  Future<File> ensureVisibleImageCapacity({
    required File imageFile,
    required int payloadSize,
    int maxMegabytes = 20,
  }) async {
    final l10n = S.of(context)!;

    Uint8List bytes = await imageFile.readAsBytes();
    img.Image? decoded = img.decodeImage(bytes);

    if (decoded == null) return imageFile;

    int capacity = _estimateCapacity(decoded);
    if (capacity >= payloadSize) return imageFile;

    double scale = 1.2;

    while (capacity < payloadSize) {
      decoded = img.copyResize(
        decoded!,
        width: (decoded.width * scale).round(),
        height: (decoded.height * scale).round(),
        interpolation: img.Interpolation.average,
      );

      capacity = _estimateCapacity(decoded);
      scale += 0.2;

      final estimatedSizeMB =
          (decoded.width * decoded.height * 3) / (1024 * 1024);

      if (estimatedSizeMB > maxMegabytes) {
        throw Exception(
          l10n.encryptImageTooLarge(maxMegabytes.toString()),
        );
      }
    }

    final newPath = imageFile.path.replaceAll(".jpg", "_upscaled.jpg");
    final File upscaledFile = File(newPath);

    await upscaledFile.writeAsBytes(
      img.encodeJpg(decoded!, quality: 90),
    );

    return upscaledFile;
  }

  // ------------------------------------------------------------
  // ⭐ Compressione intelligente immagine visibile
  // ------------------------------------------------------------
  Future<File> compressIfNeeded(File file) async {
    const int maxSize = 2 * 1024 * 1024;
    final int fileSize = await file.length();

    if (fileSize <= maxSize) return file;

    final Uint8List bytes = await file.readAsBytes();
    final img.Image? decoded = img.decodeImage(bytes);

    if (decoded == null) return file;

    final img.Image resized = img.copyResize(
      decoded,
      width: 1920,
      height: 1080,
      interpolation: img.Interpolation.average,
    );

    final List<int> compressedBytes = img.encodeJpg(resized, quality: 80);

    final String newPath = file.path.replaceAll(".jpg", "_compressed.jpg");
    final File compressedFile = File(newPath);

    await compressedFile.writeAsBytes(compressedBytes);

    return compressedFile;
  }

  // ------------------------------------------------------------
  // ⭐ Seleziona immagine visibile
  // ------------------------------------------------------------
  Future<void> pickVisibleImage() async {
    final XFile? imgFile = await _picker.pickImage(source: ImageSource.gallery);

    if (imgFile != null) {
      File original = File(imgFile.path);
      File optimized = await compressIfNeeded(original);

      setState(() => visibleImage = optimized);
    }
  }

  void _onSecretSelected(Map<String, dynamic> secret) {
    setState(() {
      selectedSecret = secret;
      showSecretReadyBanner = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => showSecretReadyBanner = false);
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // ------------------------------------------------------------
  // ⭐ PREVIEW PRIMA DELLA CRIPTAZIONE
  // ------------------------------------------------------------
  Future<bool> _showEncryptPreview({
    required int payloadSize,
    required int capacity,
  }) async {
    final l10n = S.of(context)!;

    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (_) => AlertDialog(
            title: Text(l10n.encryptPreviewTitle),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    "${l10n.encryptPreviewPayloadSize}: ${payloadSize ~/ 1024} KB"),
                Text("${l10n.encryptPreviewCapacity}: ${capacity ~/ 1024} KB"),
                const SizedBox(height: 10),
                if (visibleImage != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      visibleImage!,
                      height: 80,
                    ),
                  ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(l10n.encryptPreviewCancel),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(l10n.encryptPreviewProceed),
              ),
            ],
          ),
        ) ??
        false;
  }

  // ------------------------------------------------------------
  // ⭐ FUNZIONE CRIPTA + INVIA P2P (NUOVO SISTEMA)
  // ------------------------------------------------------------
  Future<void> _encryptAndShare() async {
    final l10n = S.of(context)!;

    if (visibleImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.encryptPickVisibleImage)),
      );
      return;
    }

    if (selectedSecret == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.encryptSelectSecret)),
      );
      return;
    }

    if (selectedContacts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.encryptSelectRecipientsTitle)),
      );
      return;
    }

    try {
      // 1) ECC KEYS
      final eccKeys = await StorageService.getECCKeys();
      final myPrivateKey = eccKeys["privateKey"];
      final myPublicKey = eccKeys["publicKey"];

      if (myPrivateKey == null || myPublicKey == null) {
        throw Exception(l10n.encryptErrorNoECC);
      }

      // 2) UNIVERSAL KEY
      final universalKey = await StorageService.getUniversalKey();

      // 3) SHARED SECRETS
      final ecc = ECCService();
      final List<String> sharedSecrets = [];

      for (final c in selectedContacts) {
        final contactPublicKey = c["publicKey"];
        if (contactPublicKey == null) continue;

        final sharedSecret = universalKey != null
            ? universalKey
            : await ecc.computeSharedSecret(
                privateKey: myPrivateKey,
                publicKey: contactPublicKey,
              );

        sharedSecrets.add(sharedSecret);
      }

      if (sharedSecrets.isEmpty) {
        throw Exception(l10n.encryptErrorNoRecipients);
      }

      // 4) PAYLOAD
      late List<int> payloadBytes;
      late PayloadType payloadType;

      switch (selectedSecret!["type"]) {
        case "text":
          payloadBytes = utf8.encode(selectedSecret!["payload"]);
          payloadType = PayloadType.text;
          break;

        case "image":
          payloadBytes = await (selectedSecret!["file"] as File).readAsBytes();
          payloadType = PayloadType.image;
          break;

        case "audio":
          payloadBytes = await (selectedSecret!["file"] as File).readAsBytes();
          payloadType = PayloadType.audio;
          break;

        case "sandwich":
          payloadBytes = utf8.encode(jsonEncode(selectedSecret));
          payloadType = PayloadType.text;
          break;

        default:
          throw Exception(l10n.encryptErrorUnsupported);
      }

      // 5) CAPACITÀ IMMAGINE + PREVIEW
      final decoded = img.decodeImage(await visibleImage!.readAsBytes());
      final capacity = decoded != null ? _estimateCapacity(decoded) : 0;

      final proceed = await _showEncryptPreview(
        payloadSize: payloadBytes.length,
        capacity: capacity,
      );

      if (!proceed) return;

      // 6) INTERPOLAZIONE AUTOMATICA
      visibleImage = await ensureVisibleImageCapacity(
        imageFile: visibleImage!,
        payloadSize: payloadBytes.length,
      );

      // 7) CRIPTAZIONE — FULLSCREEN NEON
      setState(() => isProcessing = true);

      final crypto = CryptoService();
      final stegoFile = await crypto.encrypt(
        visibleImagePath: visibleImage!.path,
        sharedSecrets: sharedSecrets,
        payloadBytes: payloadBytes,
        type: payloadType,
      );

      // ------------------------------------------------------------
      // ⭐ 8) INVIO P2P — NUOVO SISTEMA
      // ------------------------------------------------------------
      final c = selectedContacts.first;

      final contact = WWContact(
        userId: c["userId"]!,
        name: c["name"] ?? "",
        lastName: c["lastName"] ?? "",
        phone: c["phone"] ?? "",
        publicKey: c["publicKey"],
        qrData: c["qrData"] ?? "",
        peerId: c["peerId"],
        fingerprint: c["fingerprint"],
        version: c["version"] != null ? int.parse(c["version"]!) : 1,
      );

      await WebRTCManager.instance.sendFile(
        contact: contact,
        file: stegoFile,
        fileType: "image",
      );

      if (mounted) Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${l10n.encryptErrorGeneric}: $e")),
      );
    } finally {
      setState(() => isProcessing = false);
    }
  }

  // ------------------------------------------------------------
  // ⭐ BUILD
  // ------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;
    final theme = Provider.of<ColorProvider>(context);

    return WinkWinkScaffold(
      showColorSelector: false,
      child: Stack(
        children: [
          ListView(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            children: [
              const SizedBox(height: 10),

              if (showSecretReadyBanner)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade600,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    l10n.encryptSecretReady,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),

              Text(
                l10n.encryptTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  shadows: [
                    Shadow(
                      blurRadius: 3,
                      color: Colors.white,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              Text(
                l10n.encryptSelectRecipientsTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 30),

              // 🔘 STEP 1 — CONTATTI
              MiniNeonButton(
                label: l10n.encryptContactsButton,
                icon: Icons.contacts,
                onPressed: () async {
                  final result = await Navigator.pushNamed(
                    context,
                    "/contacts_encrypt",
                  );

                  if (result is List<Map<String, String>>) {
                    setState(() => selectedContacts = result);
                  }
                },
              ),

              if (selectedContacts.isNotEmpty) ...[
                const SizedBox(height: 30),

                Text(
                  l10n.encryptVisibleImageTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                // 🔘 STEP 2 — IMMAGINE VISIBILE
                MiniNeonButton(
                  label: l10n.encryptPickVisibleImage,
                  icon: Icons.image,
                  onPressed: pickVisibleImage,
                ),

                if (visibleImage != null) ...[
                  const SizedBox(height: 20),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        visibleImage!,
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    l10n.encryptWhatToHide,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (selectedSecret == null) ...[
                    MiniNeonButton(
                      label: l10n.encryptHideImage,
                      icon: Icons.image,
                      onPressed: () async {
                        final result = await Navigator.pushNamed(
                          context,
                          "/hide_image_secret",
                          arguments: {"mode": "encrypt"},
                        );

                        if (result is Map<String, dynamic>) {
                          _onSecretSelected(result);
                        }
                      },
                    ),
                    MiniNeonButton(
                      label: l10n.encryptHideText,
                      icon: Icons.text_fields,
                      onPressed: () async {
                        final result = await Navigator.pushNamed(
                          context,
                          "/text_secret",
                          arguments: {"mode": "encrypt"},
                        );

                        if (result is Map<String, dynamic>) {
                          _onSecretSelected(result);
                        }
                      },
                    ),
                    MiniNeonButton(
                      label: l10n.encryptHideCamera,
                      icon: Icons.photo_camera,
                      onPressed: () async {
                        final result = await Navigator.pushNamed(
                          context,
                          "/camera_secret",
                          arguments: {"mode": "encrypt"},
                        );

                        if (result is Map<String, dynamic>) {
                          _onSecretSelected(result);
                        }
                      },
                    ),
                    MiniNeonButton(
                      label: l10n.encryptHideAudio,
                      icon: Icons.mic,
                      onPressed: () async {
                        final result = await Navigator.pushNamed(
                          context,
                          "/audio_secret",
                          arguments: {"mode": "encrypt"},
                        );

                        if (result is Map<String, dynamic>) {
                          _onSecretSelected(result);
                        }
                      },
                    ),
                    MiniNeonButton(
                      label: l10n.encryptHideSandwich,
                      icon: Icons.layers,
                      onPressed: () async {
                        final result = await Navigator.pushNamed(
                          context,
                          "/sandwich_secret",
                          arguments: {"mode": "encrypt"},
                        );

                        if (result is Map<String, dynamic>) {
                          _onSecretSelected(result);
                        }
                      },
                    ),
                  ],
                  if (selectedSecret != null) ...[
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        "${l10n.encryptSelectedContent}: ${selectedSecret!['type']}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFC99700),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC99700),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () {
                          setState(() => selectedSecret = null);
                        },
                        child: Text(
                          l10n.changeSecret,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    MiniNeonButton(
                      label: l10n.encryptButton,
                      icon: Icons.lock,
                      onPressed: _encryptAndShare,
                    ),
                  ],
                ],
              ],
            ],
          ),
          if (isProcessing)
            Container(
              color: Colors.black.withOpacity(0.85),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFC99700),
                  strokeWidth: 4,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

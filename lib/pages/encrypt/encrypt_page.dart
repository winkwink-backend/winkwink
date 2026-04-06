import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:winkwink/generated/l10n/app_localizations.dart';

import '../../widgets/winkwink_scaffold.dart';
import '../../providers/color_provider.dart';
import '../../widgets/mini_neon_button.dart';

import '../../services/storage_service.dart';
import '../../services/ecc_service.dart';
import '../../services/steganography_service.dart';

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

  // ⭐ Seleziona immagine visibile + compressione automatica
  Future<void> pickVisibleImage() async {
    final XFile? imgFile = await _picker.pickImage(source: ImageSource.gallery);
    if (imgFile != null) {
      File original = File(imgFile.path);
      File optimized = await compressIfNeeded(original);

      setState(() {
        visibleImage = optimized;
      });
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
  // 🔥 FUNZIONE CRIPTA COMPLETA
  // ------------------------------------------------------------
  Future<void> _encryptAndShare() async {
    final l10n = AppLocalizations.of(context)!;

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
      // ------------------------------------------------------------
      // 🔥 1. Recupera chiavi ECC personali
      // ------------------------------------------------------------
      final eccKeys = await StorageService.getECCKeys();
      final myPrivateKey = eccKeys["privateKey"];
      final myPublicKey = eccKeys["publicKey"];

      if (myPrivateKey == null || myPublicKey == null) {
        throw Exception("Chiavi ECC non trovate");
      }

      // ------------------------------------------------------------
      // 🔥 2. Recupera chiave universale (Passepartout)
      // ------------------------------------------------------------
      final universalKey = await StorageService.getUniversalKey();

      // ------------------------------------------------------------
      // 🔥 3. Calcola shared secrets per ogni destinatario
      // ------------------------------------------------------------
      final ecc = ECCService();
      final List<Map<String, dynamic>> recipients = [];

      for (final c in selectedContacts) {
        final contactPublicKey = c["publicKey"];

        if (contactPublicKey == null) continue;

        final sharedSecret = universalKey != null
            ? universalKey // modalità Passepartout
            : await ecc.computeSharedSecret(
                privateKey: myPrivateKey,
                publicKey: contactPublicKey,
              );

        recipients.add({
          "name": c["name"],
          "publicKey": contactPublicKey,
          "sharedSecret": sharedSecret,
        });
      }

      // ------------------------------------------------------------
      // 🔥 4. Costruisci payload JSON
      // ------------------------------------------------------------
      final payload = {
        "senderPublicKey": myPublicKey,
        "recipients": recipients,
        "secret": selectedSecret,
        "timestamp": DateTime.now().millisecondsSinceEpoch,
        "mode": universalKey != null ? "passepartout" : "personal",
      };

      final payloadBytes = utf8.encode(jsonEncode(payload));

      // ------------------------------------------------------------
      // 🔥 5. Steganografia
      // ------------------------------------------------------------
      final stegoFile = await SteganographyService().embedPayload(
        imagePath: visibleImage!.path,
        payload: payloadBytes,
      );

      // ------------------------------------------------------------
      // 🔥 6. Share sheet
      // ------------------------------------------------------------
      await Share.shareXFiles([XFile(stegoFile.path)]);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Errore: $e")),
      );
    }
  }

  // ------------------------------------------------------------
  // 🔥 BUILD
  // ------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Provider.of<ColorProvider>(context);

    return WinkWinkScaffold(
      showColorSelector: false,
      child: ListView(
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
                style: const TextStyle(color: Colors.white, fontSize: 16),
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
                arguments: {"mode": "encrypt"},
              );
              if (result is List<Map<String, String>>) {
                setState(() {
                  selectedContacts = result;
                });
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

              // ⭐ SE NON È STATO SCELTO ANCORA UN SEGRETO
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
                    if (result != null)
                      _onSecretSelected(result as Map<String, dynamic>);
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
                    if (result != null)
                      _onSecretSelected(result as Map<String, dynamic>);
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
                    if (result != null)
                      _onSecretSelected(result as Map<String, dynamic>);
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
                    if (result != null)
                      _onSecretSelected(result as Map<String, dynamic>);
                  },
                ),
                MiniNeonButton(
                  label: l10n.encryptHideVideo,
                  icon: Icons.videocam,
                  onPressed: () async {
                    final result = await Navigator.pushNamed(
                      context,
                      "/video_secret",
                      arguments: {"mode": "encrypt"},
                    );
                    if (result != null)
                      _onSecretSelected(result as Map<String, dynamic>);
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
                    if (result != null)
                      _onSecretSelected(result as Map<String, dynamic>);
                  },
                ),
              ],

              // ⭐ SE IL SEGRETO È GIÀ STATO SCELTO
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
                          horizontal: 30, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedSecret = null;
                      });
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

                // 🔥 PULSANTE CRIPTA COMPLETO
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
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:winkwink/generated/l10n/app_localizations.dart';

import '../../widgets/winkwink_scaffold.dart';
import '../../providers/color_provider.dart';
import '../../widgets/mini_neon_button.dart';

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

  Future<void> pickVisibleImage() async {
    final XFile? img = await _picker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      setState(() {
        visibleImage = File(img.path);
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
              child: const Text(
                "Contenuto nascosto pronto ✔",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 16),
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

          const Text(
            "Scegli con chi vuoi condividere i tuoi file segreti",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 30),

          // 🔘 STEP 1 — CONTATTI
          MiniNeonButton(
            label: "Contatti",
            icon: Icons.contacts,
            onPressed: () async {
              final result = await Navigator.pushNamed(
                context,
                "/contacts_encrypt",
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

            const Text(
              "Scegli immagine visibile a tutti",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // 🔘 STEP 2 — IMMAGINE VISIBILE
            MiniNeonButton(
              label: "Immagine",
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

              const Text(
                "Cosa vuoi nascondere?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // ⭐ SE NON È STATO SCELTO ANCORA UN SEGRETO
              if (selectedSecret == null) ...[
                MiniNeonButton(
                  label: "Nascondi immagine",
                  icon: Icons.image,
                  onPressed: () async {
                    final result = await Navigator.pushNamed(
                      context,
                      "/hide_image_secret",
                    );
                    if (result != null)
                      _onSecretSelected(result as Map<String, dynamic>);
                  },
                ),
                MiniNeonButton(
                  label: "Testo",
                  icon: Icons.text_fields,
                  onPressed: () async {
                    final result = await Navigator.pushNamed(
                      context,
                      "/text_secret",
                    );
                    if (result != null)
                      _onSecretSelected(result as Map<String, dynamic>);
                  },
                ),
                MiniNeonButton(
                  label: "Fotocamera",
                  icon: Icons.photo_camera,
                  onPressed: () async {
                    final result = await Navigator.pushNamed(
                      context,
                      "/camera_secret",
                    );
                    if (result != null)
                      _onSecretSelected(result as Map<String, dynamic>);
                  },
                ),
                MiniNeonButton(
                  label: "Audio",
                  icon: Icons.mic,
                  onPressed: () async {
                    final result = await Navigator.pushNamed(
                      context,
                      "/audio_secret",
                    );
                    if (result != null)
                      _onSecretSelected(result as Map<String, dynamic>);
                  },
                ),
                MiniNeonButton(
                  label: "Video",
                  icon: Icons.videocam,
                  onPressed: () async {
                    final result = await Navigator.pushNamed(
                      context,
                      "/video_secret",
                    );
                    if (result != null)
                      _onSecretSelected(result as Map<String, dynamic>);
                  },
                ),
              ],

              // ⭐ SE IL SEGRETO È GIÀ STATO SCELTO
              if (selectedSecret != null) ...[
                const SizedBox(height: 20),

                // ⭐ TESTO ORA COLOR OCRA
                Center(
                  child: Text(
                    "Contenuto selezionato: ${selectedSecret!['type']}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFC99700), // ⭐ OCRA
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ⭐ PULSANTE CAMBIA SEGRETO
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
              ],
            ],
          ],

          const SizedBox(height: 30),

          // 🔘 CRIPTA ORA
          MiniNeonButton(
            label: "Cripta Ora",
            icon: Icons.lock,
            onPressed: selectedSecret == null
                ? () {}
                : () {
                    // 🔥 Steganografia + share sheet
                  },
          ),
        ],
      ),
    );
  }
}

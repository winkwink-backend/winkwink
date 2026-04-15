import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../widgets/winkwink_scaffold.dart';
import '../../widgets/mini_neon_button.dart';
import '../../providers/color_provider.dart';
import 'package:winkwink/generated/l10n.dart';

import '../../services/storage_service.dart';
import '../../services/ecc_service.dart';
import '../../services/video_crypto_service.dart';
import '../../services/video_steganography_service.dart';

import 'video_ww_sandwich.dart';
import 'video_camera_b4.dart';

// ⭐ NUOVO IMPORT
import '../../services/webrtc_manager.dart';
import 'package:winkwink/models/ww_contact.dart';

class VideoWWPage extends StatefulWidget {
  const VideoWWPage({super.key});

  @override
  State<VideoWWPage> createState() => _VideoWWPageState();
}

class _VideoWWPageState extends State<VideoWWPage> {
  final ImagePicker _picker = ImagePicker();

  List<Map<String, String>> selectedContacts = [];
  File? visibleVideo;
  int visibleVideoSize = 0;

  Map<String, dynamic>? invisiblePayload;

  bool showSecretReadyBanner = false;
  bool isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ColorProvider>(context);
    final l10n = S.of(context)!;

    return WinkWinkScaffold(
      showColorSelector: false,
      child: Stack(
        children: [
          ListView(
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
                    l10n.videoWWSecretReady,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),

              Text(
                l10n.videoWWTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                l10n.encryptSelectRecipientsTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 30),

              // ⭐ STEP 1 — CONTATTI
              MiniNeonButton(
                label: l10n.contactsButton,
                icon: Icons.contacts,
                onPressed: _pickContacts,
              ),

              if (selectedContacts.isNotEmpty) ...[
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      l10n.videoWWVisibleVideo,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text(l10n.videoWWDurationTitle),
                            content: Text(l10n.videoWWDurationMessage),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(l10n.ok),
                              ),
                            ],
                          ),
                        );
                      },
                      child:
                          const Icon(Icons.help_outline, color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                MiniNeonButton(
                  label: l10n.videoWWRecord,
                  icon: Icons.videocam,
                  onPressed: _recordVisibleVideo,
                ),
                MiniNeonButton(
                  label: l10n.videoWWPickFromGallery,
                  icon: Icons.video_file,
                  onPressed: _pickVisibleVideoFromGallery,
                ),
                if (visibleVideo != null) ...[
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      "${l10n.videoWWSelectedVideo} (${(visibleVideoSize / 1024 / 1024).toStringAsFixed(1)} MB)",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  MiniNeonButton(
                    label: l10n.delete,
                    icon: Icons.delete,
                    onPressed: () {
                      setState(() {
                        visibleVideo = null;
                        visibleVideoSize = 0;
                        invisiblePayload = null;
                      });
                    },
                  ),
                  const SizedBox(height: 30),
                  MiniNeonButton(
                    label: l10n.videoWWSandwichWhatToHide,
                    icon: Icons.layers,
                    onPressed: _openSandwich,
                  ),
                ],
              ],

              if (invisiblePayload != null) ...[
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    l10n.videoWWSecretSelected,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFC99700),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                MiniNeonButton(
                  label: l10n.encryptAndSend,
                  icon: Icons.lock,
                  onPressed: _encryptAndSendP2P,
                ),
              ],
            ],
          ),

          // ⭐ OVERLAY NEON DURANTE CRIPTAZIONE
          if (isProcessing)
            Container(
              color: Colors.black.withOpacity(0.85),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFC99700),
                          width: 4,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFC99700).withOpacity(0.7),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(20),
                        child: CircularProgressIndicator(
                          color: Color(0xFFC99700),
                          strokeWidth: 4,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      l10n.encryptProgressEncrypting,
                      style: const TextStyle(
                        color: Color(0xFFC99700),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Color(0xFFC99700),
                            blurRadius: 12,
                          ),
                        ],
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

  // ------------------------------------------------------------
  // ⭐ CONTATTI
  // ------------------------------------------------------------
  Future<void> _pickContacts() async {
    final result = await Navigator.pushNamed(
      context,
      "/contacts_encrypt",
    );

    if (result is List<Map<String, String>>) {
      setState(() => selectedContacts = result);
    }
  }

  // ------------------------------------------------------------
  // ⭐ REGISTRA VIDEO
  // ------------------------------------------------------------
  Future<void> _recordVisibleVideo() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const VideoCameraB4()),
    );

    if (result is Map && result["file"] != null) {
      final file = result["file"] as File;
      final size = await file.length();

      setState(() {
        visibleVideo = file;
        visibleVideoSize = size;
      });
    }
  }

  // ------------------------------------------------------------
  // ⭐ VIDEO DA GALLERIA
  // ------------------------------------------------------------
  Future<void> _pickVisibleVideoFromGallery() async {
    final XFile? file = await _picker.pickVideo(source: ImageSource.gallery);
    if (file == null) return;

    final f = File(file.path);
    final size = await f.length();

    setState(() {
      visibleVideo = f;
      visibleVideoSize = size;
    });
  }

  // ------------------------------------------------------------
  // ⭐ SANDWICH
  // ------------------------------------------------------------
  Future<void> _openSandwich() async {
    if (visibleVideo == null) return;

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VideoWWSandwich(
          maxPayloadBytes: (visibleVideoSize * 0.20).floor(),
          visibleVideoBytes: visibleVideoSize,
        ),
      ),
    );

    if (result is Map) {
      setState(() {
        invisiblePayload = Map<String, dynamic>.from(result);
        showSecretReadyBanner = true;
      });

      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) setState(() => showSecretReadyBanner = false);
      });
    }
  }

  // ------------------------------------------------------------
  // ⭐ STEGO + ECC + INVIO P2P (NUOVO SISTEMA)
  // ------------------------------------------------------------
  Future<void> _encryptAndSendP2P() async {
    final l10n = S.of(context)!;

    if (visibleVideo == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.videoWWErrorNoVideo)),
      );
      return;
    }

    if (invisiblePayload == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.videoWWErrorNoSecret)),
      );
      return;
    }

    if (selectedContacts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.videoWWErrorNoRecipients)),
      );
      return;
    }

    try {
      final eccKeys = await StorageService.getECCKeys();
      final myPrivateKey = eccKeys["privateKey"];
      final myPublicKey = eccKeys["publicKey"];

      if (myPrivateKey == null || myPublicKey == null) {
        throw Exception(l10n.encryptErrorNoECC);
      }

      final universalKey = await StorageService.getUniversalKey();
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

      final payloadBytes = utf8.encode(jsonEncode(invisiblePayload));
      final payloadType = PayloadType.text;

      setState(() => isProcessing = true);

      final videoCrypto = VideoCryptoService();
      final stegoFile = await videoCrypto.encryptVideo(
        visibleVideoPath: visibleVideo!.path,
        sharedSecrets: sharedSecrets,
        payloadBytes: payloadBytes,
        type: payloadType,
      );

      // ------------------------------------------------------------
      // ⭐ INVIO P2P — NUOVO SISTEMA
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
        fileType: "video",
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
}

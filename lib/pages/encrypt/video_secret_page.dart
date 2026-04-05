import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/winkwink_scaffold.dart';
import '../../widgets/mini_neon_button.dart';
import '../../providers/color_provider.dart';

import 'package:winkwink/generated/l10n/app_localizations.dart';

import 'video_camera_b4.dart';

// MEDIA KIT
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

// VIDEO COMPRESS
import 'package:video_compress/video_compress.dart';

class VideoSecretPage extends StatefulWidget {
  const VideoSecretPage({super.key});

  @override
  State<VideoSecretPage> createState() => _VideoSecretPageState();
}

class _VideoSecretPageState extends State<VideoSecretPage> {
  File? recordedVideo;

  late final Player player;
  late final VideoController videoController;

  bool playerInitialized = false;

  final ImagePicker _picker = ImagePicker();

  // 🔥 Stato compressione
  bool isCompressing = false;
  double compressProgress = 0.0;

  @override
  void initState() {
    super.initState();
    player = Player();
    videoController = VideoController(player);

    // Listener avanzamento compressione (versione corretta)
    VideoCompress.compressProgress$.subscribe((progress) {
      if (mounted) {
        setState(() => compressProgress = progress);
      }
    });
  }

  /// 🎥 REGISTRA NUOVO VIDEO
  Future<void> openCamera() async {
    await player.stop();

    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const VideoCameraB4()),
    );

    if (result != null && result is Map && result["file"] != null) {
      final file = result["file"];
      if (file is File) {
        recordedVideo = file;
        await loadVideo();
      }
    }
  }

  /// 📥 IMPORTA DALLA GALLERIA + 🔥 COMPRESSIONE AUTOMATICA + 🚫 LIMITE 100MB
  Future<void> importFromGallery() async {
    final l10n = AppLocalizations.of(context)!;

    try {
      final XFile? video = await _picker.pickVideo(
        source: ImageSource.gallery,
        maxDuration: const Duration(seconds: 15),
      );

      if (video == null) return;

      // 🚫 BLOCCO FILE > 100MB
      final fileSize = await File(video.path).length();
      if (fileSize > 100 * 1024 * 1024) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.videoTooLarge),
          ),
        );
        return;
      }

      await player.stop();

      // 🔥 COMPRESSIONE AUTOMATICA
      setState(() {
        isCompressing = true;
        compressProgress = 0.0;
      });

      final compressed = await VideoCompress.compressVideo(
        video.path,
        quality: VideoQuality.MediumQuality, // 720p
        deleteOrigin: false,
      );

      setState(() => isCompressing = false);

      if (compressed != null && compressed.file != null) {
        recordedVideo = compressed.file;
      } else {
        recordedVideo = File(video.path);
      }

      await loadVideo();
    } catch (e) {
      debugPrint("❌ Errore selezione galleria: $e");
      setState(() => isCompressing = false);
    }
  }

  /// 🎞 CARICA VIDEO IN MEDIAKIT
  Future<void> loadVideo() async {
    if (recordedVideo == null) return;

    try {
      await player.open(
        Media(recordedVideo!.path),
        play: false,
      );

      await player.setVolume(100.0);

      setState(() => playerInitialized = true);
    } catch (e) {
      debugPrint("❌ Errore caricamento video MediaKit: $e");
    }
  }

  void deleteVideo() {
    player.stop();
    setState(() {
      recordedVideo = null;
      playerInitialized = false;
    });
  }

  @override
  void dispose() {
    player.dispose();
    VideoCompress.cancelCompression();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ColorProvider>(context);
    final l10n = AppLocalizations.of(context)!;

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
            l10n.videoSecretTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            "Massimo 15 secondi",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 30),

          MiniNeonButton(
            label: "Registra Video",
            icon: Icons.videocam,
            onPressed: openCamera,
          ),

          const SizedBox(height: 10),

          MiniNeonButton(
            label: "Carica dalla Galleria",
            icon: Icons.video_library,
            onPressed: importFromGallery,
          ),

          // 🔥 UI compressione
          if (isCompressing) ...[
            const SizedBox(height: 20),
            const Text(
              "Compressione in corso...",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: compressProgress / 100,
              minHeight: 8,
            ),
            const SizedBox(height: 20),
          ],

          if (recordedVideo != null && playerInitialized) ...[
            const SizedBox(height: 30),
            SizedBox(
              height: 400,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: SizedBox(
                    width: 300,
                    height: 600,
                    child: Video(controller: videoController),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: IconButton(
                iconSize: 32,
                color: Colors.red.shade700,
                icon: const Icon(Icons.delete),
                onPressed: deleteVideo,
              ),
            ),
            const SizedBox(height: 20),
            MiniNeonButton(
              label: l10n.okButton,
              icon: Icons.check,
              onPressed: () {
                Navigator.pop(context, {
                  "type": "video",
                  "file": recordedVideo,
                });
              },
            ),
          ],
        ],
      ),
    );
  }
}

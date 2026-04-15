import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../providers/color_provider.dart';

class VideoCameraB4A extends StatefulWidget {
  final int maxSeconds; // tempo massimo dinamico

  const VideoCameraB4A({
    super.key,
    required this.maxSeconds,
  });

  @override
  State<VideoCameraB4A> createState() => _VideoCameraB4AState();
}

class _VideoCameraB4AState extends State<VideoCameraB4A>
    with TickerProviderStateMixin {
  CameraController? cameraController;
  List<CameraDescription>? cameras;

  bool isRecording = false;
  bool isInitialized = false;

  XFile? recordedXFile;
  File? recordedVideo;
  VideoPlayerController? videoController;

  CameraDescription? currentCamera;

  int recordingSeconds = 0;
  Timer? recordingTimer;

  // Animazione pulsante REC
  late AnimationController pulseController;
  late Animation<double> pulseAnimation;

  @override
  void initState() {
    super.initState();
    initCamera();

    pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: pulseController, curve: Curves.easeInOut),
    );
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();
    if (cameras == null || cameras!.isEmpty) return;

    currentCamera = cameras!.firstWhere(
      (c) => c.lensDirection == CameraLensDirection.back,
      orElse: () => cameras!.first,
    );

    await startCamera(currentCamera!);
  }

  Future<void> startCamera(CameraDescription cam) async {
    cameraController = CameraController(
      cam,
      ResolutionPreset.medium,
      enableAudio: true,
    );

    try {
      await cameraController!.initialize();
      await cameraController!.prepareForVideoRecording();
    } catch (e) {
      debugPrint("❌ Errore camera: $e");
      return;
    }

    if (!mounted) return;

    setState(() {
      currentCamera = cam;
      isInitialized = true;
    });
  }

  Future<void> switchCamera() async {
    if (cameras == null || cameras!.length < 2) return;

    final newCam = cameras!.firstWhere(
      (c) => c.lensDirection != currentCamera!.lensDirection,
      orElse: () => cameras!.first,
    );

    await safeDisposeCamera();
    setState(() => isInitialized = false);
    await startCamera(newCam);
  }

  // ------------------------------------------------------------
  // START RECORDING — Metodo A (stabile)
  // ------------------------------------------------------------
  Future<void> startRecording() async {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return;
    }

    try {
      await Future.delayed(const Duration(milliseconds: 200));

      await cameraController!.startVideoRecording();

      setState(() {
        isRecording = true;
        recordingSeconds = 0;
      });

      // TIMER SECONDI
      recordingTimer?.cancel();
      recordingTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!isRecording) return;

        setState(() => recordingSeconds++);

        if (recordingSeconds >= widget.maxSeconds) {
          stopRecording();
        }
      });
    } catch (e) {
      debugPrint("❌ Errore registrazione: $e");
    }
  }

  // ------------------------------------------------------------
  // STOP RECORDING — Metodo A
  // ------------------------------------------------------------
  Future<void> stopRecording() async {
    if (!isRecording) return;

    recordingTimer?.cancel();

    try {
      recordedXFile = await cameraController!.stopVideoRecording();
      recordedVideo = File(recordedXFile!.path);

      await loadVideo();
    } catch (e) {
      debugPrint("❌ Errore stop: $e");
    } finally {
      setState(() => isRecording = false);
    }
  }

  Future<void> loadVideo() async {
    await safeDisposeVideo();

    if (recordedVideo == null) return;

    videoController = VideoPlayerController.file(recordedVideo!);

    try {
      await videoController!.initialize();
      await videoController!.setVolume(1.0);
    } catch (e) {
      debugPrint("❌ Errore VideoPlayer: $e");
    }

    setState(() {});
  }

  Future<void> safeDisposeCamera() async {
    await cameraController?.dispose();
    cameraController = null;
  }

  Future<void> safeDisposeVideo() async {
    await videoController?.dispose();
    videoController = null;
  }

  void deleteVideo() async {
    await safeDisposeVideo();

    setState(() {
      recordedVideo = null;
      recordedXFile = null;
      recordingSeconds = 0;
    });

    if (currentCamera != null) await startCamera(currentCamera!);
  }

  @override
  void dispose() {
    recordingTimer?.cancel();
    pulseController.dispose();
    safeDisposeCamera();
    safeDisposeVideo();
    super.dispose();
  }

  // ------------------------------------------------------------
  // UI
  // ------------------------------------------------------------
  Widget framed(Widget child, Color color) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: child,
      ),
    );
  }

  Widget recordButton(Color color) {
    return ScaleTransition(
      scale: isRecording ? pulseAnimation : const AlwaysStoppedAnimation(1.0),
      child: Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: color, width: 6),
          boxShadow: [
            if (isRecording)
              BoxShadow(
                color: color.withOpacity(0.7),
                blurRadius: 25,
                spreadRadius: 5,
              ),
          ],
        ),
        child: GestureDetector(
          onTap: () => isRecording ? stopRecording() : startRecording(),
          child: Center(
            child: Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isRecording ? Colors.redAccent : color,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget glowButton(IconData icon, VoidCallback onTap, Color color) {
    return Container(
      width: 65,
      height: 65,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.6),
            blurRadius: 20,
            spreadRadius: 3,
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black, size: 32),
        onPressed: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ColorProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // CAMERA PREVIEW
          if (recordedVideo == null)
            Positioned.fill(
              child: isInitialized
                  ? framed(
                      AspectRatio(
                        aspectRatio: cameraController!.value.aspectRatio,
                        child: CameraPreview(cameraController!),
                      ),
                      theme.primary,
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),

          // VIDEO PLAYER
          if (recordedVideo != null &&
              videoController != null &&
              videoController!.value.isInitialized)
            Positioned.fill(
              child: Center(
                child: framed(
                  AspectRatio(
                    aspectRatio: videoController!.value.aspectRatio,
                    child: VideoPlayer(videoController!),
                  ),
                  theme.primary,
                ),
              ),
            ),

          // ⭐ COUNTDOWN (cerchio bianco alfa 20, numeri rossi)
          if (isRecording)
            Positioned(
              top: 40,
              right: 20,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    "${widget.maxSeconds - recordingSeconds}",
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

          // BARRA INFERIORE
          if (recordedVideo == null)
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  glowButton(
                      Icons.close, () => Navigator.pop(context), theme.primary),
                  recordButton(theme.primary),
                  glowButton(Icons.cameraswitch, switchCamera, theme.primary),
                ],
              ),
            ),

          // POST-REGISTRAZIONE
          if (recordedVideo != null)
            Positioned(
              bottom: 40,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  glowButton(Icons.delete, deleteVideo, theme.primary),
                  glowButton(
                    Icons.check,
                    () => Navigator.pop(context, {"file": recordedVideo}),
                    theme.primary,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

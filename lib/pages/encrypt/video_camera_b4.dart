import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../providers/color_provider.dart';

class VideoCameraB4 extends StatefulWidget {
  const VideoCameraB4({super.key});

  @override
  State<VideoCameraB4> createState() => _VideoCameraB4State();
}

class _VideoCameraB4State extends State<VideoCameraB4> {
  CameraController? cameraController;
  List<CameraDescription>? cameras;

  bool isRecording = false;
  bool isInitialized = false;

  Timer? timer;
  int seconds = 0;
  final int maxSeconds = 15;

  File? recordedVideo;
  VideoPlayerController? videoController;

  CameraDescription? currentCamera;

  @override
  void initState() {
    super.initState();
    initCamera();
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
      ResolutionPreset.low,
      enableAudio: true,
    );

    try {
      await cameraController!.initialize();
      // FIX AUDIO: Preparazione hardware
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

  Future<void> startRecording() async {
    if (cameraController == null || !cameraController!.value.isInitialized)
      return;

    try {
      await Future.delayed(const Duration(milliseconds: 200));
      await cameraController!.startVideoRecording();

      setState(() {
        isRecording = true;
        seconds = 0;
      });

      timer = Timer.periodic(const Duration(seconds: 1), (t) {
        setState(() => seconds++);
        if (seconds >= maxSeconds) stopRecording();
      });
    } catch (e) {
      debugPrint("❌ Errore registrazione: $e");
    }
  }

  Future<void> stopRecording() async {
    if (!isRecording) return;
    timer?.cancel();

    try {
      XFile file = await cameraController!.stopVideoRecording();
      recordedVideo = File(file.path);
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
    });
    if (currentCamera != null) await startCamera(currentCamera!);
  }

  @override
  void dispose() {
    timer?.cancel();
    safeDisposeCamera();
    safeDisposeVideo();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ColorProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Anteprima Camera
          if (recordedVideo == null)
            Positioned.fill(
              child: isInitialized
                  ? CameraPreview(cameraController!)
                  : const Center(child: CircularProgressIndicator()),
            ),

          // Anteprima Video Registrato
          if (recordedVideo != null &&
              videoController != null &&
              videoController!.value.isInitialized)
            Positioned.fill(
              child: Center(
                child: AspectRatio(
                  aspectRatio: videoController!.value.aspectRatio,
                  child: VideoPlayer(videoController!),
                ),
              ),
            ),

          // Tasto Chiudi
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 36),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // Tasto Switch
          if (!isRecording && recordedVideo == null && isInitialized)
            Positioned(
              top: 40,
              right: 20,
              child: IconButton(
                icon: const Icon(Icons.cameraswitch,
                    color: Colors.white, size: 36),
                onPressed: switchCamera,
              ),
            ),

          // Timer
          if (isRecording)
            Positioned(
              top: 40,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  "$seconds / $maxSeconds",
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: theme.primary),
                ),
              ),
            ),

          // Tasto Registra
          if (recordedVideo == null)
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () => isRecording ? stopRecording() : startRecording(),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isRecording ? Colors.redAccent : theme.primary,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                  ),
                ),
              ),
            ),

          // Azioni Post-Registrazione
          if (recordedVideo != null)
            Positioned(
              bottom: 40,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete,
                        color: Colors.redAccent, size: 40),
                    onPressed: deleteVideo,
                  ),
                  IconButton(
                    icon: const Icon(Icons.check_circle,
                        color: Colors.greenAccent, size: 40),
                    onPressed: () =>
                        Navigator.pop(context, {"file": recordedVideo}),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

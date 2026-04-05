import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../widgets/winkwink_scaffold.dart';
import '../../widgets/mini_neon_button.dart';
import '../../providers/color_provider.dart';
import 'package:winkwink/generated/l10n/app_localizations.dart';

class AudioSecretPage extends StatefulWidget {
  const AudioSecretPage({super.key});

  @override
  State<AudioSecretPage> createState() => _AudioSecretPageState();
}

class _AudioSecretPageState extends State<AudioSecretPage> {
  final FlutterSoundRecorder recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer player = FlutterSoundPlayer();

  bool isRecording = false;
  bool isPlaying = false;

  File? recordedFile;
  Duration recordedDuration = Duration.zero;
  Duration playPosition = Duration.zero;

  Timer? _timer;
  Timer? _waveTimer;

  List<double> bars = List.generate(12, (_) => 5);

  @override
  void initState() {
    super.initState();
    recorder.openRecorder();
    player.openPlayer();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    player.closePlayer();
    _timer?.cancel();
    _waveTimer?.cancel();
    super.dispose();
  }

  // 🔥 PERMESSO MICROFONO
  Future<bool> ensureMicPermission() async {
    var status = await Permission.microphone.status;

    if (status.isDenied || status.isRestricted) {
      status = await Permission.microphone.request();
    }

    return status.isGranted;
  }

  // 🎤 AVVIO REGISTRAZIONE (WAV PCM)
  Future<void> startRecording() async {
    bool ok = await ensureMicPermission();
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Permesso microfono negato")),
      );
      return;
    }

    final dir = await getTemporaryDirectory();
    final path =
        "${dir.path}/winkwink_audio_${DateTime.now().millisecondsSinceEpoch}.wav";

    await recorder.startRecorder(
      toFile: path,
      codec: Codec.pcm16WAV, // WAV PCM = boost possibile
      sampleRate: 44100,
      numChannels: 1,
    );

    setState(() {
      isRecording = true;
      recordedFile = File(path);
      recordedDuration = Duration.zero;
      playPosition = Duration.zero;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        recordedDuration += const Duration(seconds: 1);
      });
    });

    final random = Random();
    _waveTimer = Timer.periodic(const Duration(milliseconds: 120), (_) {
      setState(() {
        bars = List.generate(12, (_) => random.nextDouble() * 40 + 5);
      });
    });
  }

  // 🛑 STOP REGISTRAZIONE
  Future<void> stopRecording() async {
    await recorder.stopRecorder();

    _timer?.cancel();
    _waveTimer?.cancel();

    // BOOST VOLUME SOFTWARE
    await _boostVolumeWav();

    setState(() {
      isRecording = false;
    });
  }

  // 🔊 BOOST VOLUME WAV (x3)
  Future<void> _boostVolumeWav() async {
    if (recordedFile == null) return;

    final bytes = await recordedFile!.readAsBytes();

    // WAV header = 44 bytes → i campioni iniziano dopo
    final pcm = bytes.sublist(44).buffer.asInt16List();

    const double gain = 3.0;

    for (int i = 0; i < pcm.length; i++) {
      pcm[i] = (pcm[i] * gain).clamp(-32768, 32767).toInt();
    }

    // riscrivi WAV: header + PCM amplificato
    final newBytes = Uint8List.fromList([
      ...bytes.sublist(0, 44),
      ...pcm.buffer.asUint8List(),
    ]);

    await recordedFile!.writeAsBytes(newBytes);
  }

  // ▶️ RIPRODUZIONE
  Future<void> startPlayback() async {
    if (recordedFile == null) return;

    await player.setVolume(1.0);

    await player.startPlayer(
      fromURI: recordedFile!.path,
      codec: Codec.pcm16WAV,
      whenFinished: () {
        setState(() {
          isPlaying = false;
          playPosition = Duration.zero;
        });
      },
    );

    setState(() {
      isPlaying = true;
    });

    player.onProgress!.listen((event) {
      setState(() {
        playPosition = event.position;
      });
    });
  }

  // ⏹ STOP RIPRODUZIONE
  Future<void> stopPlayback() async {
    await player.stopPlayer();
    setState(() {
      isPlaying = false;
      playPosition = Duration.zero;
    });
  }

  // 🗑 CANCELLA AUDIO
  void deleteRecording() {
    stopPlayback();
    setState(() {
      recordedFile = null;
      recordedDuration = Duration.zero;
      playPosition = Duration.zero;
    });
  }

  // 🌈 WAVEFORM
  Widget buildWaveform(Color neon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: bars
          .map(
            (h) => AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: 6,
              height: h,
              decoration: BoxDecoration(
                color: neon,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: neon.withOpacity(0.6),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Provider.of<ColorProvider>(context);

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
            l10n.audioSecretTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            l10n.audioSecretSubtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 30),
          MiniNeonButton(
            label: isRecording ? "Stop" : "Registra",
            icon: isRecording ? Icons.stop : Icons.mic,
            onPressed: () {
              if (isRecording) {
                stopRecording();
              } else {
                startRecording();
              }
            },
          ),
          const SizedBox(height: 20),
          if (isRecording) ...[
            Center(child: buildWaveform(theme.background)),
            const SizedBox(height: 16),
            Center(
              child: Text(
                "${recordedDuration.inMinutes}:${(recordedDuration.inSeconds % 60).toString().padLeft(2, '0')}",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: theme.text,
                ),
              ),
            ),
          ],
          if (recordedFile != null && !isRecording) ...[
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 40,
                  color: theme.text,
                  icon: Icon(isPlaying ? Icons.stop : Icons.play_arrow),
                  onPressed: () {
                    if (isPlaying) {
                      stopPlayback();
                    } else {
                      startPlayback();
                    }
                  },
                ),
                const SizedBox(width: 20),
                IconButton(
                  iconSize: 32,
                  color: Colors.red.shade700,
                  icon: const Icon(Icons.delete),
                  onPressed: deleteRecording,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                isPlaying
                    ? "Riproduzione: ${playPosition.inSeconds}s"
                    : "Durata: ${recordedDuration.inMinutes}:${(recordedDuration.inSeconds % 60).toString().padLeft(2, '0')}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: theme.text,
                ),
              ),
            ),
            const SizedBox(height: 30),
            MiniNeonButton(
              label: l10n.okButton,
              icon: Icons.check,
              onPressed: () {
                Navigator.pop(context, {
                  "type": "audio",
                  "file": recordedFile,
                });
              },
            ),
          ],
        ],
      ),
    );
  }
}

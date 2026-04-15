import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:provider/provider.dart';

import '../../widgets/winkwink_scaffold.dart';
import '../../widgets/mini_neon_button.dart';
import '../../providers/color_provider.dart';
import 'package:winkwink/generated/l10n.dart';

class SandwichItem {
  final String type; // image, text, audio, camera
  final dynamic data; // File or String
  final int size;

  SandwichItem({
    required this.type,
    required this.data,
    required this.size,
  });

  Map<String, dynamic> toJson() => {
        "type": type,
        "size": size,
        "data": type == "text" ? data : (data as File).readAsBytesSync(),
      };
}

class SandwichSecretPage extends StatefulWidget {
  const SandwichSecretPage({super.key});

  @override
  State<SandwichSecretPage> createState() => _SandwichSecretPageState();
}

class _SandwichSecretPageState extends State<SandwichSecretPage> {
  final List<SandwichItem> sandwich = [];

  static const int maxSandwichSize = 5 * 1024 * 1024; // 5 MB

  bool isCompressing = false;
  double compressProgress = 0.0;

  // ⭐ Calcolo peso totale
  int getTotalSize() {
    int total = 0;
    for (var item in sandwich) {
      total += item.size;
    }
    return total;
  }

  // ⭐ Barra di avanzamento
  double getProgress() {
    return getTotalSize() / maxSandwichSize;
  }

  // ⭐ Compressione intelligente
  Future<File> compressIfNeeded(File file) async {
    const int maxSize = 2 * 1024 * 1024; // 2 MB
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

  // ⭐ Multi-selezione immagini
  Future<void> pickMultipleImages() async {
    final List<XFile> files = await ImagePicker().pickMultiImage();
    if (files.isEmpty) return;

    setState(() {
      isCompressing = true;
      compressProgress = 0.0;
    });

    final List<File> compressedImages = [];

    for (int i = 0; i < files.length; i++) {
      final original = File(files[i].path);
      final compressed = await compressIfNeeded(original);
      compressedImages.add(compressed);

      setState(() {
        compressProgress = (i + 1) / files.length;
      });
    }

    setState(() => isCompressing = false);

    // ⭐ Aggiungi immagini
    for (final imgFile in compressedImages) {
      final size = await imgFile.length();

      if (getTotalSize() + size > maxSandwichSize) {
        _showLimitDialog();
        break;
      }

      setState(() {
        sandwich.add(
          SandwichItem(
            type: "image",
            data: imgFile,
            size: size,
          ),
        );
      });
    }
  }

  // ⭐ Aggiungi da altre pagine
  Future<void> addFromPage(String route, String type) async {
    final result = await Navigator.pushNamed(
      context,
      route,
      arguments: {"mode": "sandwich"},
    );

    if (result == null) return;

    final map = result as Map<String, dynamic>;
    final payload = map["payload"];

    int size;

    if (payload is String) {
      size = payload.length;
    } else if (payload is File) {
      size = await payload.length();
    } else if (payload is List<int>) {
      size = payload.length;
    } else {
      return;
    }

    if (getTotalSize() + size > maxSandwichSize) {
      _showLimitDialog();
      return;
    }

    setState(() {
      sandwich.add(
        SandwichItem(
          type: type,
          data: payload,
          size: size,
        ),
      );
    });
  }

  void _showLimitDialog() {
    final l10n = S.of(context)!;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(l10n.sandwichLimitExceeded),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.sandwichOk),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;

    return WinkWinkScaffold(
      showColorSelector: false,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        iconSize: 36,
                        icon: const Icon(
                          Icons.keyboard_double_arrow_left,
                        ),
                        color: Colors.black,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      l10n.sandwichTitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      l10n.sandwichSubtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 20),

                    LinearProgressIndicator(
                      value: getProgress(),
                      backgroundColor: Colors.grey.shade300,
                      color: Colors.green,
                      minHeight: 10,
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "${(getTotalSize() / (1024 * 1024)).toStringAsFixed(2)} MB / 5 MB",
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black),
                    ),

                    const SizedBox(height: 30),

                    // ⭐ Bottoni (SENZA VIDEO)
                    MiniNeonButton(
                      label: l10n.sandwichImportGallery,
                      icon: Icons.image,
                      onPressed: pickMultipleImages,
                    ),

                    MiniNeonButton(
                      label: l10n.sandwichAddCamera,
                      icon: Icons.photo_camera,
                      onPressed: () => addFromPage("/camera_secret", "camera"),
                    ),

                    MiniNeonButton(
                      label: l10n.sandwichAddText,
                      icon: Icons.text_fields,
                      onPressed: () => addFromPage("/text_secret", "text"),
                    ),

                    MiniNeonButton(
                      label: l10n.sandwichAddAudio,
                      icon: Icons.mic,
                      onPressed: () => addFromPage("/audio_secret", "audio"),
                    ),

                    // ❌ RIMOSSO: pulsante VIDEO

                    const SizedBox(height: 30),

                    // ⭐ Lista riordinabile
                    if (sandwich.isNotEmpty)
                      SizedBox(
                        height: 400,
                        child: ReorderableListView.builder(
                          itemCount: sandwich.length,
                          onReorder: (oldIndex, newIndex) {
                            setState(() {
                              if (newIndex > oldIndex) newIndex -= 1;
                              final item = sandwich.removeAt(oldIndex);
                              sandwich.insert(newIndex, item);
                            });
                          },
                          itemBuilder: (context, index) {
                            final item = sandwich[index];

                            return Card(
                              key: ValueKey(item),
                              color: Colors.white,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                leading: Icon(
                                  item.type == "image"
                                      ? Icons.image
                                      : item.type == "text"
                                          ? Icons.text_fields
                                          : item.type == "audio"
                                              ? Icons.mic
                                              : Icons.photo_camera,
                                  color: Colors.black,
                                ),
                                title: Text(
                                  "${item.type.toUpperCase()} — ${(item.size / (1024 * 1024)).toStringAsFixed(2)} MB",
                                  style: const TextStyle(color: Colors.black),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.drag_handle,
                                        color: Colors.grey),
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () {
                                        setState(() {
                                          sandwich.removeAt(index);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ],
          ),

          // ⭐ Pulsante fisso in basso
          if (sandwich.isNotEmpty)
            Positioned(
              left: 0,
              right: 0,
              bottom: 20,
              child: Center(
                child: MiniNeonButton(
                  label: l10n.sandwichConfirm,
                  icon: Icons.check,
                  onPressed: () {
                    Navigator.pop(context, {
                      "type": "sandwich",
                      "payload": sandwich.map((e) => e.toJson()).toList(),
                    });
                  },
                ),
              ),
            ),

          // ⭐ Overlay compressione
          if (isCompressing)
            Container(
              color: Colors.black.withOpacity(0.45),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(color: Colors.white),
                    const SizedBox(height: 20),
                    const Text(
                      "Elaborazione immagini…",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        value: compressProgress,
                        minHeight: 8,
                        color: Colors.white,
                        backgroundColor: Colors.white24,
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
}

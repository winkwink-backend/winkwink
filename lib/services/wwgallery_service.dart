import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:winkwink/services/notification_service.dart';

class WWGalleryService {
  // ------------------------------------------------------------
  // 📁 METODO PRIVATO (rimane per uso interno)
  // ------------------------------------------------------------
  static Future<Directory> _getGalleryDir() async {
    final dir = await getApplicationDocumentsDirectory();
    final gallery = Directory("${dir.path}/wwgallery");

    if (!await gallery.exists()) {
      await gallery.create(recursive: true);
    }

    return gallery;
  }

  // ------------------------------------------------------------
  // 📁 METODO PUBBLICO — USATO DA WebRTCManager e P2PReceivePage
  // ------------------------------------------------------------
  static Future<Directory> getGalleryDir() async {
    return _getGalleryDir();
  }

  // ------------------------------------------------------------
  // 🔥 SALVA UN QR NELLA WINKGALLERY
  // ------------------------------------------------------------
  static Future<void> saveQr(String qrData) async {
    final gallery = await _getGalleryDir();
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    // Estrai dati dal QR (solo legacy)
    final parts = qrData.split("|");
    if (parts.length != 6) return;

    final firstName = parts[2];
    final lastName = parts[3];
    final phone = parts[4];

    // Salva JSON metadati
    final meta = {
      "name": "$firstName $lastName",
      "phone": phone,
      "qrData": qrData,
      "path": "${gallery.path}/qr_$timestamp.png",
      "type": "qr",
      "timestamp": timestamp
    };

    final metaFile = File("${gallery.path}/qr_$timestamp.json");
    await metaFile.writeAsString(jsonEncode(meta));

    // Salva immagine QR come PNG (placeholder)
    final imgFile = File("${gallery.path}/qr_$timestamp.png");
    await imgFile.writeAsBytes([]);

    // 🔥 Controllo spazio e notifica se supera 1GB
    final overLimit = await isOverLimit();
    if (overLimit) {
      await NotificationService.notifyGalleryFull();
    }
  }

  // ------------------------------------------------------------
  // 🔥 CARICA TUTTI I FILE SALVATI
  // ------------------------------------------------------------
  static Future<List<Map<String, dynamic>>> loadAllQr() async {
    final gallery = await _getGalleryDir();
    final files = gallery.listSync();

    final List<Map<String, dynamic>> result = [];

    for (final f in files) {
      if (f.path.endsWith(".json")) {
        final jsonString = await File(f.path).readAsString();
        final data = jsonDecode(jsonString);

        // Verifica che il file immagine esista
        if (await File(data["path"]).exists()) {
          result.add(data);
        }
      }
    }

    // 🔥 Ordina per data (più recente → prima)
    result.sort((a, b) {
      final tA = a["timestamp"] ?? 0;
      final tB = b["timestamp"] ?? 0;
      return tB.compareTo(tA);
    });

    return result;
  }

  // ------------------------------------------------------------
  // 🔥 ELIMINA UN FILE DALLA WINKGALLERY
  // ------------------------------------------------------------
  static Future<void> deleteItem(String path) async {
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }

    final jsonPath = path.replaceAll(".png", ".json");
    final metaFile = File(jsonPath);
    if (await metaFile.exists()) {
      await metaFile.delete();
    }
  }

  // ------------------------------------------------------------
  // 🔥 CALCOLA LO SPAZIO TOTALE OCCUPATO (in MB)
  // ------------------------------------------------------------
  static Future<int> getUsedSpaceMB() async {
    final gallery = await _getGalleryDir();
    final files = gallery.listSync();

    int totalBytes = 0;

    for (final f in files) {
      if (f is File) {
        totalBytes += await f.length();
      }
    }

    return (totalBytes / (1024 * 1024)).round();
  }

  // ------------------------------------------------------------
  // 🔥 CONTROLLA SE SUPERA 1GB
  // ------------------------------------------------------------
  static Future<bool> isOverLimit() async {
    final used = await getUsedSpaceMB();
    return used > 1024; // 1GB
  }
}

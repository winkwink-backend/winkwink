import 'dart:io';
import 'package:image/image.dart' as img;

class SteganographyService {
  /// EMBEDDING — Inserisce payload nell’immagine PNG
  Future<File> embedPayload({
    required String imagePath,
    required List<int> payload,
  }) async {
    // 1) Carica immagine
    final originalBytes = await File(imagePath).readAsBytes();
    final image = img.decodeImage(originalBytes);

    if (image == null) {
      throw Exception("Impossibile decodificare l'immagine");
    }

    // 2) Converti payload in bit
    final payloadBits = _bytesToBits(payload);

    // 3) Controlla capacità immagine
    final capacity = image.width * image.height * 4; // 4 canali RGBA
    if (payloadBits.length > capacity) {
      throw Exception("Payload troppo grande per questa immagine");
    }

    int bitIndex = 0;

    // 4) Inserisci bit nei pixel
    for (int y = 0; y < image.height; y++) {
      for (int x = 0; x < image.width; x++) {
        final pixel = image.getPixel(x, y);

        int r = pixel.r.toInt();
        int g = pixel.g.toInt();
        int b = pixel.b.toInt();
        int a = pixel.a.toInt();

        r = _setLsb(r, payloadBits, bitIndex++);
        g = _setLsb(g, payloadBits, bitIndex++);
        b = _setLsb(b, payloadBits, bitIndex++);
        a = _setLsb(a, payloadBits, bitIndex++);

        image.setPixelRgba(x, y, r, g, b, a);

        if (bitIndex >= payloadBits.length) break;
      }
      if (bitIndex >= payloadBits.length) break;
    }

    // 5) Salva immagine
    final output = File("${imagePath}_steg.png");
    await output.writeAsBytes(img.encodePng(image));

    return output;
  }

  /// EXTRACTION — Estrae payload dall’immagine PNG
  Future<List<int>> extractPayload({
    required String imagePath,
  }) async {
    final bytes = await File(imagePath).readAsBytes();
    final image = img.decodeImage(bytes);

    if (image == null) {
      throw Exception("Impossibile decodificare l'immagine");
    }

    final extractedBits = <int>[];

    // 1) Estrai tutti i bit LSB
    for (int y = 0; y < image.height; y++) {
      for (int x = 0; x < image.width; x++) {
        final pixel = image.getPixel(x, y);

        extractedBits.add(pixel.r.toInt() & 1);
        extractedBits.add(pixel.g.toInt() & 1);
        extractedBits.add(pixel.b.toInt() & 1);
        extractedBits.add(pixel.a.toInt() & 1);
      }
    }

    // 2) Converti bit → bytes
    return _bitsToBytes(extractedBits);
  }

  // -------------------------
  // UTILITIES
  // -------------------------

  int _setLsb(int value, List<int> bits, int index) {
    if (index >= bits.length) return value;
    return (value & 0xFE) | bits[index];
  }

  List<int> _bytesToBits(List<int> bytes) {
    final bits = <int>[];
    for (final byte in bytes) {
      for (int i = 7; i >= 0; i--) {
        bits.add((byte >> i) & 1);
      }
    }
    return bits;
  }

  List<int> _bitsToBytes(List<int> bits) {
    final bytes = <int>[];
    for (int i = 0; i < bits.length; i += 8) {
      int byte = 0;
      for (int j = 0; j < 8; j++) {
        byte = (byte << 1) | bits[i + j];
      }
      bytes.add(byte);
    }
    return bytes;
  }
}
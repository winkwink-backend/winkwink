import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

enum PayloadType {
  text,
  image,
  audio,
  video,
  sandwich,
}

class VideoSteganographyService {
  static const magic = "WWSTEG";

  /// EMBED: aggiunge il payload alla fine del file MP4
  Future<File> embedPayloadInVideo({
    required String videoPath,
    required List<int> payload,
  }) async {
    final videoFile = File(videoPath);
    final bytes = await videoFile.readAsBytes();

    final output = File(
      "${videoFile.parent.path}/winkwink_${DateTime.now().millisecondsSinceEpoch}.mp4",
    );

    final sink = output.openWrite();
    sink.add(bytes); // video originale
    sink.add(utf8.encode(magic)); // magic marker
    sink.add(_uint32(payload.length)); // lunghezza payload
    sink.add(payload); // payload completo
    await sink.close();

    return output;
  }

  /// EXTRACT: legge il payload dalla fine del file MP4
  Future<List<int>?> extractPayloadFromVideo(String videoPath) async {
    final file = File(videoPath);
    final bytes = await file.readAsBytes();

    final magicBytes = utf8.encode(magic);
    final magicLen = magicBytes.length;

    // Cerchiamo il magic marker dalla fine
    for (int i = bytes.length - magicLen - 4; i >= 0; i--) {
      if (_match(bytes, i, magicBytes)) {
        final lengthStart = i + magicLen;
        final lengthBytes = bytes.sublist(lengthStart, lengthStart + 4);
        final payloadLength =
            ByteData.sublistView(Uint8List.fromList(lengthBytes)).getUint32(0);

        final payloadStart = lengthStart + 4;
        final payloadEnd = payloadStart + payloadLength;

        if (payloadEnd <= bytes.length) {
          return bytes.sublist(payloadStart, payloadEnd);
        }
      }
    }

    return null;
  }

  // ------------------------------------------------------------
  // UTILITIES
  // ------------------------------------------------------------
  List<int> _uint32(int value) {
    final bd = ByteData(4)..setUint32(0, value);
    return bd.buffer.asUint8List();
  }

  bool _match(List<int> data, int offset, List<int> pattern) {
    for (int i = 0; i < pattern.length; i++) {
      if (data[offset + i] != pattern[i]) return false;
    }
    return true;
  }
}

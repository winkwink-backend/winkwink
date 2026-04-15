import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:encrypt/encrypt.dart' as enc;

import 'ecc_service.dart';
import 'video_steganography_service.dart';

class VideoCryptoService {
  final _storage = const FlutterSecureStorage();
  final _ecc = ECCService();
  final _videoSteg = VideoSteganographyService();

  // -------------------------------------------------------------
  // ENCRYPT VIDEO (un solo file)
  // -------------------------------------------------------------
  Future<File> encryptVideo({
    required String visibleVideoPath,
    required List<String> sharedSecrets,
    required List<int> payloadBytes,
    required PayloadType type,
  }) async {
    // 1) Deriva chiavi AES
    final aesKeys = sharedSecrets.map(_deriveAesKey).toList();

    // 2) Cifra payload
    final encryptedPayload = _aesEncrypt(payloadBytes, aesKeys.first);

    // 3) Header WWSTEG
    final header = _buildHeader(
      sharedSecrets: sharedSecrets,
      encryptedPayload: encryptedPayload,
      type: type,
    );

    // 4) Payload finale
    final fullPayload = [...header, ...encryptedPayload];

    // 5) Appendi al video
    final stegoVideo = await _videoSteg.embedPayloadInVideo(
      videoPath: visibleVideoPath,
      payload: fullPayload,
    );

    return stegoVideo;
  }

  // -------------------------------------------------------------
  // DECRYPT VIDEO (un solo file)
  // -------------------------------------------------------------
  Future<({PayloadType type, List<int> bytes})> decryptVideo(
    String videoPath,
  ) async {
    // 1) Estrai payload dalla fine del file
    final extracted = await _videoSteg.extractPayloadFromVideo(videoPath);

    if (extracted == null) {
      throw Exception("Nessun payload trovato nel video");
    }

    final bytes = extracted;
    int index = 0;

    // 2) Magic
    final magic = utf8.decode(bytes.sublist(0, 6));
    if (magic != "WWSTEG") throw Exception("File non valido");
    index += 6;

    // 3) Versione
    final version = bytes[index++];
    if (version != 1) throw Exception("Versione non supportata");

    // 4) Numero destinatari
    final numRecipients = bytes[index++];

    // 5) Tipo payload
    final payloadTypeIndex = bytes[index++];
    final payloadType = PayloadType.values[payloadTypeIndex];

    // 6) Lunghezza payload cifrato
    final lengthBytes = bytes.sublist(index, index + 4);
    final payloadLength =
        ByteData.sublistView(Uint8List.fromList(lengthBytes)).getUint32(0);
    index += 4;

    // 7) Hash
    final payloadHash = bytes.sublist(index, index + 32);
    index += 32;

    // 8) Shared secrets
    final sharedSecrets = <String>[];
    for (int i = 0; i < numRecipients; i++) {
      final buffer = <int>[];
      while (bytes[index] != 0) {
        buffer.add(bytes[index]);
        index++;
      }
      index++; // skip 0
      sharedSecrets.add(utf8.decode(buffer));
    }

    // 9) Payload cifrato
    final encryptedPayload = bytes.sublist(index, index + payloadLength);

    // 10) Ricostruisci shared secret
    final myPrivateKey = await _storage.read(key: 'privateKeyECC');
    final senderPublicKey = await _storage.read(key: 'senderPublicKeyECC');

    if (myPrivateKey == null || senderPublicKey == null) {
      throw Exception("Chiavi ECC mancanti");
    }

    final mySecret = await _ecc.computeSharedSecret(
      privateKey: myPrivateKey,
      publicKey: senderPublicKey,
    );

    if (!sharedSecrets.contains(mySecret)) {
      throw Exception("Non sei autorizzato ad aprire questo file");
    }

    // 11) Deriva chiave AES
    final aesKey = _deriveAesKey(mySecret);

    // 12) Decripta
    final decrypted = _aesDecrypt(encryptedPayload, aesKey);

    // 13) Verifica integrità
    final checkHash = sha256.convert(decrypted).bytes;
    if (!_listEquals(checkHash, payloadHash)) {
      throw Exception("Payload corrotto");
    }

    return (type: payloadType, bytes: decrypted);
  }

  // -------------------------------------------------------------
  // AES
  // -------------------------------------------------------------
  List<int> _aesEncrypt(List<int> data, List<int> keyBytes) {
    final key = enc.Key(Uint8List.fromList(keyBytes));
    final iv = enc.IV.fromLength(16);
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));
    return encrypter.encryptBytes(data, iv: iv).bytes;
  }

  List<int> _aesDecrypt(List<int> data, List<int> keyBytes) {
    final key = enc.Key(Uint8List.fromList(keyBytes));
    final iv = enc.IV.fromLength(16);
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));
    return encrypter.decryptBytes(
      enc.Encrypted(Uint8List.fromList(data)),
      iv: iv,
    );
  }

  // -------------------------------------------------------------
  // HEADER
  // -------------------------------------------------------------
  List<int> _buildHeader({
    required List<String> sharedSecrets,
    required List<int> encryptedPayload,
    required PayloadType type,
  }) {
    final header = <int>[];

    header.addAll(utf8.encode("WWSTEG"));
    header.add(1); // versione
    header.add(sharedSecrets.length);
    header.add(type.index);

    final lengthBytes = ByteData(4)..setUint32(0, encryptedPayload.length);
    header.addAll(lengthBytes.buffer.asUint8List());

    final hash = sha256.convert(encryptedPayload);
    header.addAll(hash.bytes);

    for (final s in sharedSecrets) {
      header.addAll(utf8.encode(s));
      header.add(0);
    }

    return header;
  }

  bool _listEquals(List<int> a, List<int> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  List<int> _deriveAesKey(String sharedSecret) {
    final digest = sha256.convert(utf8.encode(sharedSecret));
    return digest.bytes;
  }
}

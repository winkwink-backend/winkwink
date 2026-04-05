import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:encrypt/encrypt.dart' as enc;

import 'ecc_service.dart';
import 'steganography_service.dart';

/// Tipi di payload supportati
enum PayloadType {
  text,
  image,
  audio,
}

class CryptoService {
  final _storage = const FlutterSecureStorage();
  final _ecc = ECCService();
  final _steg = SteganographyService();

  // -------------------------------------------------------------
  // ENCRYPT
  // -------------------------------------------------------------
  Future<File> encrypt({
    required String visibleImagePath,
    required List<String> sharedSecrets,
    required List<int> payloadBytes,
    required PayloadType type,
  }) async {
    // 1) Deriva chiavi AES (una per destinatario)
    final aesKeys = sharedSecrets.map(_deriveAesKey).toList();

    // 2) Cifra payload con AES reale (usiamo la prima chiave)
    final encryptedPayload = _aesEncrypt(payloadBytes, aesKeys.first);

    // 3) Costruisci header completo
    final header = _buildHeader(
      sharedSecrets: sharedSecrets,
      encryptedPayload: encryptedPayload,
      type: type,
    );

    // 4) Combina header + payload cifrato
    final fullPayload = [...header, ...encryptedPayload];

    // 5) Steganografia LSB
    final output = await _steg.embedPayload(
      imagePath: visibleImagePath,
      payload: fullPayload,
    );

    return output;
  }

  // -------------------------------------------------------------
  // DECRYPT
  // -------------------------------------------------------------
  Future<({PayloadType type, List<int> bytes})> decrypt(String imagePath) async {
    // 1) Estrai payload dall’immagine
    final extracted = await _steg.extractPayload(imagePath: imagePath);

    int index = 0;

    // 2) Magic bytes
    final magic = utf8.decode(extracted.sublist(0, 6));
    if (magic != 'WWSTEG') throw Exception('File non valido');
    index += 6;

    // 3) Versione
    final version = extracted[index++];
    if (version != 1) throw Exception('Versione non supportata');

    // 4) Numero destinatari
    final numRecipients = extracted[index++];

    // 5) Tipo payload
    final payloadTypeIndex = extracted[index++];
    final payloadType = PayloadType.values[payloadTypeIndex];

    // 6) Lunghezza payload
    final lengthBytes = extracted.sublist(index, index + 4);
    final payloadLength =
        ByteData.sublistView(Uint8List.fromList(lengthBytes)).getUint32(0);
    index += 4;

    // 7) Hash payload
    final payloadHash = extracted.sublist(index, index + 32);
    index += 32;

    // 8) Shared secrets
    final sharedSecrets = <String>[];
    for (int i = 0; i < numRecipients; i++) {
      final buffer = <int>[];
      while (extracted[index] != 0) {
        buffer.add(extracted[index]);
        index++;
      }
      index++; // skip 0
      sharedSecrets.add(utf8.decode(buffer));
    }

    // 9) Payload cifrato
    final encryptedPayload =
        extracted.sublist(index, index + payloadLength);

    // 10) Ricostruisci la tua shared secret
    final myPrivateKey = await _storage.read(key: 'privateKeyECC');
    final senderPublicKey = await _storage.read(key: 'senderPublicKeyECC');

    if (myPrivateKey == null || senderPublicKey == null) {
      throw Exception('Chiavi ECC mancanti');
    }

    final mySecret = await _ecc.computeSharedSecret(
      privateKey: myPrivateKey,
      publicKey: senderPublicKey,
    );

    // 11) Verifica autorizzazione
    if (!sharedSecrets.contains(mySecret)) {
      throw Exception('Non sei autorizzato ad aprire questo file');
    }

    // 12) Deriva chiave AES
    final aesKey = _deriveAesKey(mySecret);

    // 13) Decripta AES reale
    final decrypted = _aesDecrypt(encryptedPayload, aesKey);

    // 14) Verifica integrità
    final checkHash = sha256.convert(decrypted).bytes;
    if (!_listEquals(checkHash, payloadHash)) {
      throw Exception('Payload corrotto');
    }

    return (type: payloadType, bytes: decrypted);
  }

  // -------------------------------------------------------------
  // AES REALE
  // -------------------------------------------------------------
  List<int> _aesEncrypt(List<int> data, List<int> keyBytes) {
    final key = enc.Key(Uint8List.fromList(keyBytes));
    final iv = enc.IV.fromLength(16); // IV fisso (puoi cambiarlo)
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));

    final encrypted = encrypter.encryptBytes(data, iv: iv);
    return encrypted.bytes;
  }

  List<int> _aesDecrypt(List<int> data, List<int> keyBytes) {
    final key = enc.Key(Uint8List.fromList(keyBytes));
    final iv = enc.IV.fromLength(16);
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));

    final decrypted = encrypter.decryptBytes(
      enc.Encrypted(Uint8List.fromList(data)),
      iv: iv,
    );

    return decrypted;
  }

  // -------------------------------------------------------------
  // UTILITIES
  // -------------------------------------------------------------
  List<int> _deriveAesKey(String sharedSecret) {
    final bytes = utf8.encode(sharedSecret);
    final digest = sha256.convert(bytes);
    return digest.bytes; // 32 bytes AES256
  }

  List<int> _buildHeader({
    required List<String> sharedSecrets,
    required List<int> encryptedPayload,
    required PayloadType type,
  }) {
    final header = <int>[];

    header.addAll(utf8.encode('WWSTEG')); // magic
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
}
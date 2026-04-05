import 'dart:convert';
import 'package:crypto/crypto.dart';

/// Coppia di chiavi ECC (pubblica + privata)
class EccKeyPair {
  final String publicKey;
  final String privateKey;

  EccKeyPair({
    required this.publicKey,
    required this.privateKey,
  });
}

/// Servizio ECC per WinkWink
class ECCService {
  /// Genera un ID utente univoco
  String generateUserId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  /// Genera i dati da inserire nel QR code
  String generateQrData({
    required String firstName,
    required String lastName,
    required String phone,
    required String userId,
    required String publicKeyECC,
  }) {
    // Formato QR WinkWink
    return 'WW|$userId|$firstName|$lastName|$phone|$publicKeyECC';
  }

  /// Genera una coppia di chiavi ECC (placeholder)
  ///
  /// ⚠️ Nota:
  /// Questa funzione deve essere sostituita con una libreria ECC reale.
  Future<EccKeyPair> generateKeyPair() async {
    // Placeholder: genera chiavi fittizie
    final privateKey = _fakeRandomKey();
    final publicKey = _fakeRandomKey();

    return EccKeyPair(
      publicKey: publicKey,
      privateKey: privateKey,
    );
  }

  /// Calcola la shared secret ECC (placeholder)
  ///
  /// ⚠️ Nota:
  /// Questa funzione deve essere sostituita con ECDH reale.
  Future<String> computeSharedSecret({
    required String privateKey,
    required String publicKey,
  }) async {
    // Placeholder: hash combinato delle due chiavi
    final combined = '$privateKey|$publicKey';
    final bytes = utf8.encode(combined);
    final digest = sha256.convert(bytes);

    return digest.toString();
  }

  /// Genera una stringa pseudo‑casuale (placeholder)
  String _fakeRandomKey() {
    final now = DateTime.now().microsecondsSinceEpoch.toString();
    final bytes = utf8.encode(now);
    return sha256.convert(bytes).toString();
  }
}
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import 'storage_service.dart';

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

  // ------------------------------------------------------------
  // ⭐ NUOVO QR JSON BASE64 (VERSIONE 2)
  // ------------------------------------------------------------
  ///
  /// Nuovo formato QR:
  /// - JSON con:
  ///   type, version, userId, firstName, lastName, phone,
  ///   publicKey, peerId, timestamp, fingerprint
  /// - codificato in UTF8 → Base64
  ///
  String generateQrData({
    required String firstName,
    required String lastName,
    required String phone,
    required String userId,
    required String publicKeyECC,
  }) {
    // 1) Genera peerId univoco
    final peerId = "PEER_${DateTime.now().millisecondsSinceEpoch}_$userId";

    // 2) Timestamp
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    // 3) Crea JSON base
    final Map<String, dynamic> data = {
      "type": "WW_ID",
      "version": 2,
      "userId": userId,
      "firstName": firstName,
      "lastName": lastName,
      "phone": phone,
      "publicKey": publicKeyECC,
      "peerId": peerId,
      "timestamp": timestamp,
    };

    // 4) Calcola fingerprint SHA‑256 sul JSON senza fingerprint
    final jsonString = jsonEncode(data);
    final fingerprint = sha256.convert(utf8.encode(jsonString)).toString();

    // 5) Aggiungi fingerprint
    data["fingerprint"] = fingerprint;

    // 6) Codifica in Base64
    final encoded = base64Encode(utf8.encode(jsonEncode(data)));

    // 7) Salva anche come QR personale (compatibile con StorageService)
    StorageService.saveQrData(encoded);

    return encoded;
  }

  /// 🔁 FORMATO LEGACY (se mai ti servisse ancora)
  /// Mantengo il metodo per compatibilità eventuale:
  String generateLegacyQrData({
    required String firstName,
    required String lastName,
    required String phone,
    required String userId,
    required String publicKeyECC,
  }) {
    return 'WW|$userId|$firstName|$lastName|$phone|$publicKeyECC';
  }

  /// Genera una coppia di chiavi ECC (placeholder)
  Future<EccKeyPair> generateKeyPair() async {
    final privateKey = _fakeRandomKey();
    final publicKey = _fakeRandomKey();

    return EccKeyPair(
      publicKey: publicKey,
      privateKey: privateKey,
    );
  }

  /// Calcola la shared secret ECC (placeholder)
  Future<String> computeSharedSecret({
    required String privateKey,
    required String publicKey,
  }) async {
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

  // ------------------------------------------------------------
  // NUOVE FUNZIONI ECC PER WINKWINK
  // ------------------------------------------------------------

  /// Salva la coppia di chiavi in locale
  Future<void> saveKeyPair(EccKeyPair pair) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('ecc_public_key', pair.publicKey);
    await prefs.setString('ecc_private_key', pair.privateKey);
  }

  /// Carica la coppia di chiavi dal device
  Future<EccKeyPair?> loadKeyPair() async {
    final prefs = await SharedPreferences.getInstance();
    final pub = prefs.getString('ecc_public_key');
    final priv = prefs.getString('ecc_private_key');

    if (pub == null || priv == null) return null;

    return EccKeyPair(publicKey: pub, privateKey: priv);
  }

  /// Ritorna la coppia di chiavi, generandola se non esiste
  Future<EccKeyPair> getOrCreateKeyPair() async {
    final existing = await loadKeyPair();
    if (existing != null) return existing;

    final newPair = await generateKeyPair();
    await saveKeyPair(newPair);
    return newPair;
  }

  /// Registra la chiave pubblica sul server
  Future<bool> registerPublicKey(int userId, String publicKey) async {
    final url = Uri.parse("${AppConfig.baseUrl}/keys/register");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "user_id": userId,
        "public_key": publicKey,
      }),
    );

    return response.statusCode == 200;
  }

  /// Recupera la chiave pubblica di un altro utente
  Future<String?> fetchUserPublicKey(int userId) async {
    final url = Uri.parse("${AppConfig.baseUrl}/keys/$userId");

    final response = await http.get(url);

    if (response.statusCode != 200) return null;

    final data = jsonDecode(response.body);
    return data["public_key"];
  }
}

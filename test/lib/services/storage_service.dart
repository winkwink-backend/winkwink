import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  // 🔐 CHIAVI BASE
  static const _keyPassword = 'password';
  static const _keyEmail = 'email';
  static const _keyHasPassword = 'has_password';

  // 🔑 QR PERSONALE
  static const _keyQrData = 'qr_data';

  // 🔑 ECC KEYS
  static const _keyECCPrivate = 'ecc_private_key';
  static const _keyECCPublic = 'ecc_public_key';

  // 🔑 UNIVERSAL KEY (Passepartout)
  static const _keyUniversal = 'universal_key';

  // 📇 CONTATTI
  static const _keyContacts = 'contacts_list';

  // ------------------------------------------------------------
  // 🔐 PASSWORD
  // ------------------------------------------------------------

  static Future<void> savePassword(String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyPassword, password);
  }

  static Future<String?> getPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyPassword);
  }

  static Future<void> saveHasPassword(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyHasPassword, value);
  }

  static Future<bool> getHasPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyHasPassword) ?? false;
  }

  // ------------------------------------------------------------
  // 📧 EMAIL
  // ------------------------------------------------------------

  static Future<void> saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyEmail, email);
  }

  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail);
  }

  // ------------------------------------------------------------
  // 🔑 QR PERSONALE
  // ------------------------------------------------------------

  static Future<void> saveQrData(String qr) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyQrData, qr);
  }

  static Future<String?> getQrData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyQrData);
  }

  // ------------------------------------------------------------
  // 🔐 ECC KEYS (pubblica + privata)
  // ------------------------------------------------------------

  static Future<void> saveECCKeys({
    required String privateKey,
    required String publicKey,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyECCPrivate, privateKey);
    await prefs.setString(_keyECCPublic, publicKey);
  }

  static Future<Map<String, String?>> getECCKeys() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      "privateKey": prefs.getString(_keyECCPrivate),
      "publicKey": prefs.getString(_keyECCPublic),
    };
  }

  // ------------------------------------------------------------
  // 🔑 UNIVERSAL KEY (Passepartout)
  // ------------------------------------------------------------

  static Future<void> saveUniversalKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUniversal, key);
  }

  static Future<String?> getUniversalKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUniversal);
  }

  // ------------------------------------------------------------
  // 📇 CONTATTI (lista JSON)
  // ------------------------------------------------------------

  static Future<void> saveContacts(List<Map<String, dynamic>> contacts) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(contacts);
    await prefs.setString(_keyContacts, jsonString);
  }

  static Future<List<Map<String, dynamic>>> loadContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keyContacts);

    if (jsonString == null) return [];

    final List decoded = jsonDecode(jsonString);
    return decoded.cast<Map<String, dynamic>>();
  }

  // ------------------------------------------------------------
  // 🧹 RESET COMPLETO (opzionale)
  // ------------------------------------------------------------

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

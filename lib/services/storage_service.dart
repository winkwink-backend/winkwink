import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:winkwink/services/ecc_service.dart';
import 'package:winkwink/models/ww_contact.dart';

class StorageService {
  // ------------------------------------------------------------
// 🔥 LOGIN STATE (persistenza login)
// ------------------------------------------------------------
  static Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("logged_in", value);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("logged_in") ?? false;
  }

  // ------------------------------------------------------------
  // 🔥 PROFILO UTENTE
  // ------------------------------------------------------------

  static Future<void> saveProfile({
    required String name,
    required String surname,
    required String email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("profile_name", name);
    await prefs.setString("profile_surname", surname);
    await prefs.setString("profile_email", email);
    await prefs.setString("profile_password", password);
  }

  static Future<Map<String, String?>> getProfile() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      "name": prefs.getString("profile_name"),
      "surname": prefs.getString("profile_surname"),
      "email": prefs.getString("profile_email"),
      "password": prefs.getString("profile_password"),
    };
  }

  static Future<void> clearQrData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("qr_data");
  }

  // ------------------------------------------------------------
  // 🔥 EMAIL / PASSWORD (compatibilità)
  // ------------------------------------------------------------

  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("profile_email");
  }

  static Future<String?> getPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("profile_password");
  }

  // ------------------------------------------------------------
  // 🔥 FLAG: UTENTE REGISTRATO
  // ------------------------------------------------------------

  static Future<void> setRegistered(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("registered", value);
  }

  static Future<bool> isRegistered() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("registered") ?? false;
  }

  // ------------------------------------------------------------
  // 🔥 FLAG: L’UTENTE HA UNA PASSWORD?
  // ------------------------------------------------------------

  static Future<void> setHasPassword(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("has_password", value);
  }

  static Future<bool> getHasPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("has_password") ?? false;
  }

  // ------------------------------------------------------------
  // 🔥 QR CODE PERSONALE
  // ------------------------------------------------------------

  static Future<void> saveQrData(String data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("qr_data", data);
  }

  static Future<String?> getQrData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("qr_data");
  }

  // ------------------------------------------------------------
  // 🔥 ECC KEYS
  // ------------------------------------------------------------

  static Future<Map<String, String>> getECCKeys() async {
    final prefs = await SharedPreferences.getInstance();

    String? publicKey = prefs.getString("ecc_public_key");
    String? privateKey = prefs.getString("ecc_private_key");

    if (publicKey == null || privateKey == null) {
      final ecc = ECCService();
      final pair = await ecc.generateKeyPair();

      publicKey = pair.publicKey;
      privateKey = pair.privateKey;

      await prefs.setString("ecc_public_key", publicKey);
      await prefs.setString("ecc_private_key", privateKey);
    }

    return {
      "publicKey": publicKey,
      "privateKey": privateKey,
    };
  }

  static Future<void> saveECCKeys({
    required String publicKey,
    required String privateKey,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("ecc_public_key", publicKey);
    await prefs.setString("ecc_private_key", privateKey);
  }

  static Future<void> clearECCKeys() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("ecc_public_key");
    await prefs.remove("ecc_private_key");
  }

  // ------------------------------------------------------------
  // 🔥 UNIVERSAL KEY
  // ------------------------------------------------------------

  static Future<void> saveUniversalKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("universal_key", key);
  }

  static Future<String?> getUniversalKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("universal_key");
  }

  // ------------------------------------------------------------
  // 🔥 CONTATTI GENERICI (legacy)
  // ------------------------------------------------------------

  static const _keyContacts = "contacts_list";

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
  // 🔥 CONTATTI WINKWINK (WWContact)
  // ------------------------------------------------------------

  static const _keyWWContacts = "ww_contacts_list";

  static Future<void> _saveWWContacts(
      List<Map<String, dynamic>> contacts) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(contacts);
    await prefs.setString(_keyWWContacts, jsonString);
  }

  static Future<List<WWContact>> getWWContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keyWWContacts);

    if (jsonString == null) return [];

    final List decoded = jsonDecode(jsonString);

    return decoded
        .map((e) => WWContact.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static Future<void> saveOrUpdateWWContact(WWContact contact) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keyWWContacts);

    List<Map<String, dynamic>> list = [];

    if (jsonString != null) {
      final List decoded = jsonDecode(jsonString);
      list = decoded.cast<Map<String, dynamic>>();
    }

    final index = list.indexWhere((c) => c["userId"] == contact.userId);

    if (index >= 0) {
      list[index] = contact.toJson();
    } else {
      list.add(contact.toJson());
    }

    await _saveWWContacts(list);
  }

  static Future<void> deleteWWContact(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keyWWContacts);

    if (jsonString == null) return;

    final List decoded = jsonDecode(jsonString);
    List<Map<String, dynamic>> list = decoded.cast<Map<String, dynamic>>();

    list.removeWhere((c) => c["userId"] == userId);

    await _saveWWContacts(list);
  }

  // ------------------------------------------------------------
  // 🔥 INBOX (campanella)
  // ------------------------------------------------------------

  static const _keyInbox = "inbox_items";

  static Future<void> saveInboxItem(Map<String, dynamic> item) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keyInbox);

    List<Map<String, dynamic>> list = [];

    if (jsonString != null) {
      final List decoded = jsonDecode(jsonString);
      list = decoded.cast<Map<String, dynamic>>();
    }

    list.add(item);

    await prefs.setString(_keyInbox, jsonEncode(list));
  }

  static Future<List<Map<String, dynamic>>> getInboxItems() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keyInbox);

    if (jsonString == null) return [];

    final List decoded = jsonDecode(jsonString);
    return decoded.cast<Map<String, dynamic>>();
  }

  static Future<void> removeInboxItem(Map<String, dynamic> item) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keyInbox);

    if (jsonString == null) return;

    final List decoded = jsonDecode(jsonString);
    List<Map<String, dynamic>> list = decoded.cast<Map<String, dynamic>>();

    list.removeWhere((i) =>
        i["timestamp"] == item["timestamp"] &&
        i["type"] == item["type"] &&
        i["qrData"] == item["qrData"]);

    await prefs.setString(_keyInbox, jsonEncode(list));
  }

  // ------------------------------------------------------------
  // ⭐⭐⭐ USER ID — NUOVO ⭐⭐⭐
  // ------------------------------------------------------------

  static Future<void> saveUserId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("user_id", id);
  }

  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt("user_id");
  }

  // ------------------------------------------------------------
  // ⭐⭐⭐ METODI MANCANTI (compatibilità)
  // ------------------------------------------------------------

  static Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  static Future<void> setBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  // Alias compatibilità vecchio codice
  static Future<void> addOrUpdateContact(Map<String, dynamic> c) async {
    await saveOrUpdateWWContact(WWContact.fromJson(c));
  }

  static Future<void> deleteContact(String userId) async {
    await deleteWWContact(userId);
  }

  // Alias compatibilità notifiche vecchie
  static Future<void> saveNotifications(List<Map<String, dynamic>> list) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyInbox, jsonEncode(list));
  }

  static Future<List<Map<String, dynamic>>> loadNotifications() async {
    return getInboxItems();
  }
}

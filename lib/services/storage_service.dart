import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
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

  // ------------------------------------------------------------
  // 🔥 EMAIL (compatibilità)
  // ------------------------------------------------------------

  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("profile_email");
  }

  // ------------------------------------------------------------
  // 🔥 PASSWORD (compatibilità)
  // ------------------------------------------------------------

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
  // 🔥 QR CODE (compatibilità)
  // ------------------------------------------------------------

  static Future<void> saveQrData(String data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("qr_data", data);
  }

  static Future<String?> getQrData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("qr_data");
  }
}
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const _keyPassword = 'password';
  static const _keyEmail = 'email';
  static const _keyHasPassword = 'has_password';
  static const _keyQrData = 'qr_data'; // 🔥 NUOVA CHIAVE

  // SALVA PASSWORD
  static Future<void> savePassword(String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyPassword, password);
  }

  // RECUPERA PASSWORD
  static Future<String?> getPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyPassword);
  }

  // SALVA EMAIL
  static Future<void> saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyEmail, email);
  }

  // RECUPERA EMAIL
  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail);
  }

  // SALVA FLAG PASSWORD
  static Future<void> saveHasPassword(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyHasPassword, value);
  }

  // RECUPERA FLAG PASSWORD
  static Future<bool> getHasPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyHasPassword) ?? false;
  }

  // 🔥 SALVA QR DATA
  static Future<void> saveQrData(String qr) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyQrData, qr);
  }

  // 🔥 RECUPERA QR DATA
  static Future<String?> getQrData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyQrData);
  }
}
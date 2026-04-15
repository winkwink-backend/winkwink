import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:winkwink/config/app_config.dart';

class ApiService {
  /// ⭐ Costruisce l’URL completo in modo sicuro
  static Uri buildUrl(String path) {
    // Garantisce che il path inizi con "/"
    if (!path.startsWith("/")) {
      path = "/$path";
    }
    return Uri.parse("${AppConfig.baseUrl}$path");
  }

  /// ⭐ POST generico JSON
  static Future<dynamic> post(String path, Map<String, dynamic> body) async {
    final url = buildUrl(path);

    try {
      final res = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (res.statusCode >= 200 && res.statusCode < 300) {
        return jsonDecode(res.body);
      }

      throw Exception("Errore POST $path → ${res.statusCode}");
    } catch (e) {
      throw Exception("Errore POST $path → $e");
    }
  }

  /// ⭐ GET generico
  static Future<dynamic> get(String path) async {
    final url = buildUrl(path);

    try {
      final res = await http.get(url);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        return jsonDecode(res.body);
      }

      throw Exception("Errore GET $path → ${res.statusCode}");
    } catch (e) {
      throw Exception("Errore GET $path → $e");
    }
  }

  /// ⭐ MULTIPART (upload file)
  static Future<dynamic> postMultipart(
    String path, {
    required Map<String, String> fields,
    required List<http.MultipartFile> files,
  }) async {
    final url = buildUrl(path);

    try {
      final request = http.MultipartRequest("POST", url);

      request.fields.addAll(fields);
      request.files.addAll(files);

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      }

      throw Exception("Errore MULTIPART $path → ${response.statusCode}");
    } catch (e) {
      throw Exception("Errore MULTIPART $path → $e");
    }
  }

  /// ⭐ REGISTRAZIONE UTENTE (LOGIN ECC)
  static Future<bool> registerUser({
    required String phone,
    required String publicKey,
  }) async {
    try {
      await post("/login", {
        "phone": phone,
        "publicKey": publicKey,
      });

      return true;
    } catch (e) {
      print("Errore registerUser → $e");
      return false;
    }
  }
}

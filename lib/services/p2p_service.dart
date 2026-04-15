import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:winkwink/config/app_config.dart';

class P2PService {
  // ------------------------------------------------------------
  // ⭐ Utility: costruisce URL completo in modo sicuro
  // ------------------------------------------------------------
  Uri _buildUrl(String path) {
    if (!path.startsWith("/")) {
      path = "/$path";
    }
    return Uri.parse("${AppConfig.baseUrl}$path");
  }

  // ------------------------------------------------------------
  // ⭐ Utility: chiamata HTTP sicura POST
  // ------------------------------------------------------------
  Future<Map<String, dynamic>> _safePost(String path, Map body) async {
    final url = _buildUrl(path);

    try {
      final res = await http
          .post(
            url,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 10));

      if (res.statusCode != 200) {
        throw Exception("HTTP ${res.statusCode}: ${res.body}");
      }

      return jsonDecode(res.body);
    } catch (e) {
      throw Exception("Errore POST $path → $e");
    }
  }

  // ------------------------------------------------------------
  // ⭐ Utility: chiamata HTTP sicura GET
  // ------------------------------------------------------------
  Future<Map<String, dynamic>> _safeGet(String path) async {
    final url = _buildUrl(path);

    try {
      final res = await http.get(url).timeout(const Duration(seconds: 10));

      if (res.statusCode != 200) {
        throw Exception("HTTP ${res.statusCode}: ${res.body}");
      }

      return jsonDecode(res.body);
    } catch (e) {
      throw Exception("Errore GET $path → $e");
    }
  }

  // ------------------------------------------------------------
  // ⭐ CREA SESSIONE
  // ------------------------------------------------------------
  Future<Map<String, dynamic>> createSession({
    required int fromUserId,
    required int toUserId,
    required int fileSize,
    required String fileType,
  }) async {
    return _safePost(
      "/p2p/session/create",
      {
        "from_user_id": fromUserId,
        "to_user_id": toUserId,
        "fileSize": fileSize,
        "fileType": fileType,
      },
    );
  }

  // ------------------------------------------------------------
  // ⭐ INVIA OFFER
  // ------------------------------------------------------------
  Future<void> sendOffer(String sessionId, Map<String, dynamic> offer) async {
    await _safePost(
      "/p2p/session/offer",
      {
        "session_id": sessionId,
        "offer": offer,
      },
    );
  }

  // ------------------------------------------------------------
  // ⭐ INVIA ANSWER
  // ------------------------------------------------------------
  Future<void> sendAnswer(String sessionId, Map<String, dynamic> answer) async {
    await _safePost(
      "/p2p/session/answer",
      {
        "session_id": sessionId,
        "answer": answer,
      },
    );
  }

  // ------------------------------------------------------------
  // ⭐ INVIA ICE CANDIDATE
  // ------------------------------------------------------------
  Future<void> sendCandidate(
      String sessionId, Map<String, dynamic> candidate) async {
    await _safePost(
      "/p2p/session/candidate",
      {
        "session_id": sessionId,
        "candidate": candidate,
      },
    );
  }

  // ------------------------------------------------------------
  // ⭐ RECUPERA SESSIONE COMPLETA
  // ------------------------------------------------------------
  Future<Map<String, dynamic>> getSession(String sessionId) async {
    return _safeGet("/p2p/session/$sessionId");
  }

  // ------------------------------------------------------------
  // ⭐ RECUPERA SOLO I NUOVI CANDIDATES
  // ------------------------------------------------------------
  Future<List<dynamic>> getCandidates(String sessionId) async {
    final data = await _safeGet("/p2p/session/$sessionId/candidates");
    return data["candidates"] ?? [];
  }
}

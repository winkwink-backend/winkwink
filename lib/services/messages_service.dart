import 'api_service.dart';

class MessagesService {
  /// ⭐ Recupera la lista delle conversazioni dell’utente
  static Future<List<Map<String, dynamic>>> getConversations(int userId) async {
    try {
      final data = await ApiService.get("/conversations/$userId");
      return List<Map<String, dynamic>>.from(data["conversations"] ?? []);
    } catch (e) {
      return [];
    }
  }

  /// ⭐ Recupera i messaggi tra due utenti
  static Future<List<Map<String, dynamic>>> getMessages(
      int userId, int otherId) async {
    try {
      final data = await ApiService.get("/messages/$userId/$otherId");
      return List<Map<String, dynamic>>.from(data["messages"] ?? []);
    } catch (e) {
      return [];
    }
  }

  /// ⭐ Invia un messaggio (testo già cifrato in futuro)
  static Future<bool> sendMessage({
    required int senderId,
    required int receiverId,
    required String content,
  }) async {
    try {
      await ApiService.post("/send-message", {
        "sender_id": senderId,
        "receiver_id": receiverId,
        "content": content,
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  /// ⭐ Recupera inbox (notifiche)
  static Future<List<Map<String, dynamic>>> getInbox(int userId) async {
    try {
      final data = await ApiService.get("/inbox/$userId");
      return List<Map<String, dynamic>>.from(data["inbox"] ?? []);
    } catch (e) {
      return [];
    }
  }
}

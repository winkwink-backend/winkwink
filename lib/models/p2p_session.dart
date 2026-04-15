class P2PSession {
  final String sessionId;
  final int fromUserId;
  final int toUserId;

  final Map<String, dynamic>? offer;
  final Map<String, dynamic>? answer;

  final List<dynamic> candidates;

  final int fileSize;
  final String fileType;

  final String status; // es: "created", "offer_sent", "answer_sent"
  final String createdAt; // timestamp utile per debug

  P2PSession({
    required this.sessionId,
    required this.fromUserId,
    required this.toUserId,
    required this.offer,
    required this.answer,
    required this.candidates,
    required this.fileSize,
    required this.fileType,
    required this.status,
    required this.createdAt,
  });

  factory P2PSession.fromJson(Map<String, dynamic> json) {
    return P2PSession(
      sessionId: json["session_id"] ?? "",
      fromUserId: json["from_user_id"] ?? 0,
      toUserId: json["to_user_id"] ?? 0,
      offer: json["offer"],
      answer: json["answer"],
      candidates: json["candidates"] ?? [],
      fileSize: json["fileSize"] ?? 0,
      fileType: json["fileType"] ?? "",
      status: json["status"] ?? "unknown",
      createdAt: json["created_at"] ?? "",
    );
  }
}

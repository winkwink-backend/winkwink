enum EncryptedPayloadType { image, text, audio }

class EncryptedFile {
  final String id;
  final String path;
  final EncryptedPayloadType type;
  final DateTime createdAt;

  EncryptedFile({
    required this.id,
    required this.path,
    required this.type,
    required this.createdAt,
  });
}
class WWContact {
  final String userId;
  final String name;
  final String lastName;
  final String phone;
  final String? publicKey; // può essere null
  final String qrData;

  // ⭐ Nuovi campi per QR JSON base64 (versione 2)
  final String? peerId;
  final String? fingerprint;
  final int version;

  WWContact({
    required this.userId,
    required this.name,
    required this.lastName,
    required this.phone,
    required this.publicKey,
    required this.qrData,
    this.peerId,
    this.fingerprint,
    this.version = 1, // default legacy
  });

  // ------------------------------------------------------------
  // ⭐ FROM JSON (compatibile con legacy + nuovo formato)
  // ------------------------------------------------------------
  factory WWContact.fromJson(Map<String, dynamic> json) {
    return WWContact(
      userId: json["userId"] ?? json["id"] ?? "",
      name: json["name"] ?? "",
      lastName: json["lastName"] ?? "",
      phone: json["phone"] ?? "",
      publicKey: json["publicKey"] ?? json["publicKeyECC"],
      qrData: json["qrData"] ?? "",

      // Nuovi campi (possono non esistere nei contatti legacy)
      peerId: json["peerId"],
      fingerprint: json["fingerprint"],
      version: json["version"] ?? 1,
    );
  }

  // ------------------------------------------------------------
  // ⭐ TO JSON (salva tutto, compatibile con StorageService)
  // ------------------------------------------------------------
  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "name": name,
      "lastName": lastName,
      "phone": phone,
      "publicKey": publicKey,
      "qrData": qrData,

      // Nuovi campi
      "peerId": peerId,
      "fingerprint": fingerprint,
      "version": version,
    };
  }
}

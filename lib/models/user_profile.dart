class UserProfile {
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String id;
  final String qrData;
  final String? password;

  UserProfile({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.id,
    required this.qrData,
    this.password,
  });

  // ⭐ Converti in JSON
  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "phone": phone,
      "email": email,
      "id": id,
      "qrData": qrData,
      "password": password,
    };
  }

  // ⭐ Ricostruisci da JSON
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      firstName: json["firstName"],
      lastName: json["lastName"],
      phone: json["phone"],
      email: json["email"],
      id: json["id"],
      qrData: json["qrData"],
      password: json["password"],
    );
  }
}

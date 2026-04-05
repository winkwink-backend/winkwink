class UserProfile {
  final String firstName;
  final String lastName;
  final String phone;
  final String email;        // <— AGGIUNTO
  final String id;
  final String qrData;
  final String? password;

  UserProfile({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,     // <— AGGIUNTO
    required this.id,
    required this.qrData,
    this.password,
  });
}
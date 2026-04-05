class WWContact {
  final String id;
  final String name;
  final String lastName;
  final String phone;
  final String publicKeyECC;
  final String qrData;

  WWContact({
    required this.id,
    required this.name,
    required this.lastName,
    required this.phone,
    required this.publicKeyECC,
    required this.qrData,
  });
}
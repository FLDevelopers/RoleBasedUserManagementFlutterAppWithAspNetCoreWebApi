class UserModel {
  final String id;
  final String email;
  final String? phoneNumber;
  final List<String>? role;

  const UserModel({
    required this.id,
    required this.email,
    this.phoneNumber,
    this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      role: json['roles'] != null ? List<String>.from(json['roles']) : null,
    );
  }
}

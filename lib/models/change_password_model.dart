class ChangePasswordModel {
  final String email;
  final String currentPassword;
  final String newPassword;

  const ChangePasswordModel({
    required this.email,
    required this.currentPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    };
  }
}

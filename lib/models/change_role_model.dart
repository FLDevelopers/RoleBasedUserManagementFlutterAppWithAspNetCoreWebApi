class ChangeRoleModel {
  final String userEmail;
  final String newRole;

  const ChangeRoleModel({
    required this.userEmail,
    required this.newRole,
  });

  Map<String, dynamic> toJson() {
    return {
      'userEmail': userEmail,
      'newRole': newRole,
    };
  }
}

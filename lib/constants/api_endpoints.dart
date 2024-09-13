class ApiEndpoints {
  static const String apiUri = "https://localhost:7253";

  static const String login = "$apiUri/api/Account/login";

  static const String register = "$apiUri/api/Account/register";

  static const String adminUsersCrud = "$apiUri/api/Admin/users";

  static const String adminRolesCrud = "$apiUri/api/Admin/roles";

  static const String adminChangeUserRole = "$apiUri/api/Admin/change-user-role";

  static const String adminInfoGetAndUpdate = "$apiUri/api/Admin/admin-info";

  static const String adminChangePassword = "$apiUri/api/Admin/change-admin-password";

  static const String userInfoReadUpdate = "$apiUri/api/User/user-info";

  static const String userDeleteProfile = "$apiUri/api/User/delete-user";

  static const String userChangePassword = "$apiUri/api/User/change-password";
}
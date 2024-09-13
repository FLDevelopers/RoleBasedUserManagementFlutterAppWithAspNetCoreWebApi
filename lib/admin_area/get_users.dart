import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:user_management/constants/api_endpoints.dart';
import 'package:user_management/constants/app_colors.dart';
import 'package:user_management/constants/token_handler.dart';
import 'package:user_management/models/user_model.dart';
import 'package:user_management/services/role_check.dart';
import 'package:user_management/shared/confirmation_dialog.dart';
import 'package:user_management/shared/custom_appbar.dart';
import 'package:http/http.dart' as http;
import 'package:user_management/shared/error_dialog.dart';
import 'package:user_management/shared/user_details.dart';

class GetUsers extends StatefulWidget {
  const GetUsers({super.key});

  @override
  State<GetUsers> createState() => _GetUsersState();
}

class _GetUsersState extends State<GetUsers> {
  List<UserModel> users = [];

  @override
  void initState() {
    super.initState();
    RoleCheck().checkAdminRole(context);
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final result = await http.get(
      Uri.parse(ApiEndpoints.adminUsersCrud),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${TokenHandler().getToken()}',
      },
    );

    if (result.statusCode >= 200 && result.statusCode <= 299) {
      final List<dynamic> jsonData = json.decode(result.body);
      setState(() {
        users = jsonData.map((user) => UserModel.fromJson(user)).toList();
      });
    } else {
      var errorBody = jsonDecode(result.body);
      final error = errorBody['message'] ?? "An error occurred.";

      if (!mounted) return;

      errorDialog(
        context: context,
        statusCode: result.statusCode,
        description: error,
        color: Colors.green,
      );
    }
  }

  Future<void> deleteUser({required String id}) async {
    final result = await http.delete(
      Uri.parse(ApiEndpoints.adminUsersCrud),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${TokenHandler().getToken()}',
      },
      body: jsonEncode(id),
    );

    if (result.statusCode >= 200 && result.statusCode <= 299) {
      fetchUsers();
    } else {
      var errorBody = jsonDecode(result.body);
      final error = errorBody['message'] ?? "An error occurred.";

      if (!mounted) return;

      errorDialog(
        context: context,
        statusCode: result.statusCode,
        description: error,
        color: Colors.green,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: "All Users",
        color: AppColors.adminPage,
      ),
      body: ListView.builder(
        itemCount: users.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          final user = users[index];
          return ListTile(
            title: Text(user.email),
            subtitle: Text(user.role != null && user.role!.isNotEmpty
                ? user.role!.join(', ')
                : 'No roles available'),
            leading: CircleAvatar(
              child: Text(
                user.email[0].toUpperCase(),
              ),
            ),
            trailing: IconButton(
              onPressed: () async {
                bool? confirmed = await showConfirmationDialog(
                  context: context,
                  title: "Confirm",
                  content: "Are you sure you want to delete this user",
                  color: AppColors.adminPage,
                );

                if (confirmed) {
                  deleteUser(id: user.id);
                } else {
                  return;
                }
              },
              icon: const Icon(Icons.delete),
            ),
            onTap: () {
              userDetails(
                context: context,
                user: user,
                color: AppColors.adminPage,
              );
            },
          );
        },
      ),
    );
  }
}

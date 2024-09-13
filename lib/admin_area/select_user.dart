import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:user_management/admin_area/assign_role.dart';
import 'package:user_management/constants/api_endpoints.dart';
import 'package:user_management/constants/app_colors.dart';
import 'package:user_management/constants/token_handler.dart';
import 'package:user_management/models/user_model.dart';
import 'package:user_management/services/role_check.dart';
import 'package:user_management/shared/custom_appbar.dart';
import 'package:http/http.dart' as http;
import 'package:user_management/shared/error_dialog.dart';

class SelectUser extends StatefulWidget {
  const SelectUser({super.key});

  @override
  State<SelectUser> createState() => _SelectUserState();
}

class _SelectUserState extends State<SelectUser> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: "Select User",
        color: AppColors.adminPage,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          const Text("Select user to proceed"),
          const SizedBox(height: 20),
          ListView.builder(
            itemCount: users.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              final user = users[index];
              return ListTile(
                title: Text(user.email),
                leading: CircleAvatar(
                  child: Text(
                    user.email[0].toUpperCase(),
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AssignRole(
                          email: user.email,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.arrow_forward),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AssignRole(
                        email: user.email,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:user_management/constants/app_colors.dart';
import 'package:user_management/shared/custom_appbar.dart';

class UnknownRoles extends StatefulWidget {
  const UnknownRoles({super.key});

  @override
  State<UnknownRoles> createState() => _UnknownRolesState();
}

class _UnknownRolesState extends State<UnknownRoles> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppbar(
          title: "Unknown Role", color: AppColors.unknownRolesPage),
      body: Center(
        child: Text("Unknown user Role\nContact admin to solve this issue."),
      ),
    );
  }
}

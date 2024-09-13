import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:user_management/accounts/register.dart';
import 'package:user_management/admin_area/admin_main_page.dart';
import 'package:user_management/constants/api_endpoints.dart';
import 'package:user_management/constants/token_handler.dart';
import 'package:user_management/models/login_model.dart';
import 'package:user_management/other_roles/unknown_roles.dart';
import 'package:user_management/shared/error_dialog.dart';
import 'package:user_management/shared/submit_button.dart';
import 'package:user_management/shared/text_fields.dart';
import 'package:http/http.dart' as http;
import 'package:user_management/users_area/users_main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void submitForm() async {
    if (_formKey.currentState!.validate()) {
      final loginData = LoginModel(
        email: _emailController.text,
        password: _passwordController.text,
      );

      var result = await http.post(
        Uri.parse(ApiEndpoints.login),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(loginData.toJson()),
      );

      if (result.statusCode >= 200 && result.statusCode <= 299) {
        final jsonData = json.decode(result.body);
        final token = jsonData['token'];

        TokenHandler().addToken(token);

        final decodedToken = JwtDecoder.decode(TokenHandler().getToken());

        String? role = decodedToken[
            'http://schemas.microsoft.com/ws/2008/06/identity/claims/role'];

        if (!mounted) return;

        if (role == "Admin") {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const AdminMainPage()),
            (Route<dynamic> route) => false,
          );
        } else if (role == "User") {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const UsersMainPage()),
            (Route<dynamic> route) => false,
          );
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const UnknownRoles(),
            ),
          );
        }
      } else {
        var errorData = jsonDecode(result.body);
        int statusCode = errorData['status'];
        String title = errorData['title'];

        if (!mounted) return;

        errorDialog(
          context: context,
          statusCode: statusCode,
          description: title,
          color: Colors.green,
        );
      }
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Login",
              style: TextStyle(
                fontSize: 36,
                color: Color.fromRGBO(56, 56, 56, .9),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    emailTextField(emailController: _emailController),
                    const SizedBox(height: 10),
                    passwordTextField(passwordController: _passwordController),
                    const SizedBox(height: 10),
                    submitButton(
                      context: context,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      title: "Login",
                      method: submitForm,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text.rich(
              TextSpan(
                text: "Don't have an account? ",
                style: const TextStyle(color: Colors.black87),
                children: [
                  TextSpan(
                    text: "Register Here",
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:user_management/accounts/login.dart';
import 'package:user_management/constants/token_handler.dart';

String fetchEmailFromToken({required BuildContext context}) {
  if (TokenHandler().getToken().isEmpty) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  final decodedToken = JwtDecoder.decode(TokenHandler().getToken());
  String email = decodedToken['email'];

  return email;
}

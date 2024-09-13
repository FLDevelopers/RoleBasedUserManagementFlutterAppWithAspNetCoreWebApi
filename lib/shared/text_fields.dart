import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user_management/constants/border_styles.dart';

TextFormField emailTextField({
  required TextEditingController emailController,
  bool readOnly = false,
}) {
  return TextFormField(
    controller: emailController,
    decoration: InputDecoration(
      labelText: "Email",
      floatingLabelStyle: const TextStyle(color: Colors.green),
      border: BorderStyles.border,
      focusedBorder: BorderStyles.focusedBorder,
      errorBorder: BorderStyles.errorBorder,
      focusedErrorBorder: BorderStyles.focusedErrorBorder,
    ),
    keyboardType: TextInputType.emailAddress,
    readOnly: readOnly,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your email.';
      }
      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
        return 'Please enter a valid email';
      }
      return null;
    },
  );
}

TextFormField passwordTextField({
  required TextEditingController passwordController,
  String? label,
}) {
  return TextFormField(
    controller: passwordController,
    decoration: InputDecoration(
      labelText: label ?? "Password",
      floatingLabelStyle: const TextStyle(color: Colors.green),
      border: BorderStyles.border,
      focusedBorder: BorderStyles.focusedBorder,
      errorBorder: BorderStyles.errorBorder,
      focusedErrorBorder: BorderStyles.focusedErrorBorder,
    ),
    obscureText: true,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your password.';
      }
      if (value.length < 6) {
        return "Password must be at least 6 characters";
      }
      return null;
    },
  );
}

TextFormField phoneNumberField({
  required TextEditingController phoneNumberController,
}) {
  return TextFormField(
    controller: phoneNumberController,
    decoration: InputDecoration(
      labelText: "Phone Number",
      floatingLabelStyle: const TextStyle(color: Colors.green),
      border: BorderStyles.border,
      focusedBorder: BorderStyles.focusedBorder,
      errorBorder: BorderStyles.errorBorder,
      focusedErrorBorder: BorderStyles.focusedErrorBorder,
    ),
    keyboardType: TextInputType.phone,
    inputFormatters: <TextInputFormatter>[
      FilteringTextInputFormatter.digitsOnly,
    ],
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your phone number.';
      }
      if (value.length < 7) {
        return "Phone number must be at least 7 characters";
      }
      return null;
    },
  );
}

TextField userDetailsTextField({
  required String label,
  required String value,
}) {
  return TextField(
    controller: TextEditingController(text: value),
    readOnly: true,
    decoration: InputDecoration(
      labelText: label,
      floatingLabelStyle: const TextStyle(color: Colors.green),
      border: BorderStyles.border,
      focusedBorder: BorderStyles.focusedBorder,
      errorBorder: BorderStyles.errorBorder,
      focusedErrorBorder: BorderStyles.focusedErrorBorder,
    ),
  );
}

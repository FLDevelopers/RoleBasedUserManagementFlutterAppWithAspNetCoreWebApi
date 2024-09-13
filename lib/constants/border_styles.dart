import 'package:flutter/material.dart';

class BorderStyles {
  static final OutlineInputBorder border =
      OutlineInputBorder(borderRadius: BorderRadius.circular(8.0));

  static final OutlineInputBorder focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.green, width: 2.0));

  static final OutlineInputBorder errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.red, width: 2.0));

  static final OutlineInputBorder focusedErrorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.red, width: 2.0));

  static final ShapeBorder buttonBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  );

  static final InputDecoration roleDropdownButtonFormFieldInputDecoration =
      InputDecoration(
    contentPadding:
        const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
    labelText: 'Select a role',
    labelStyle: const TextStyle(color: Colors.green),
    floatingLabelStyle: const TextStyle(color: Colors.green),
    border: BorderStyles.border,
    focusedBorder: BorderStyles.focusedBorder,
    enabledBorder: BorderStyles.border,
    errorBorder: BorderStyles.errorBorder,
    focusedErrorBorder: BorderStyles.focusedErrorBorder,
  );
}

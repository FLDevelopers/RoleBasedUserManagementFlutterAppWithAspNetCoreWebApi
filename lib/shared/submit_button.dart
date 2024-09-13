import 'package:flutter/material.dart';
import 'package:user_management/constants/border_styles.dart';

MaterialButton submitButton({
  required BuildContext context,
  required Color backgroundColor,
  required Color textColor,
  required String title,
  required VoidCallback? method,
}) {
  return MaterialButton(
    color: backgroundColor,
    textColor: textColor,
    minWidth: double.infinity,
    height: 60,
    shape: BorderStyles.buttonBorder,
    onPressed: method,
    child: Text(title),
  );
}

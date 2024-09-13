import 'package:flutter/material.dart';
import 'package:user_management/constants/border_styles.dart';

Future<bool> showConfirmationDialog({
  required BuildContext context,
  required String title,
  required String content,
  required Color color,
}) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            MaterialButton(
              color: color,
              textColor: Colors.white,
              padding: const EdgeInsets.all(18),
              hoverElevation: 0,
              elevation: 0,
              focusElevation: 0,
              shape: BorderStyles.buttonBorder,
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("Cancel"),
            ),
            MaterialButton(
              color: color,
              textColor: Colors.white,
              padding: const EdgeInsets.all(18),
              hoverElevation: 0,
              elevation: 0,
              focusElevation: 0,
              shape: BorderStyles.buttonBorder,
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("Confirm"),
            )
          ],
        );
      }).then((value) => value ?? false);
}

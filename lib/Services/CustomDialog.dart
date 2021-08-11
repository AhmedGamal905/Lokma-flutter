import 'package:flutter/material.dart';
import 'package:lokma/helpers/constant/Colors.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String body;
  final String buttonText;
  final Function buttonOnPressed;

  CustomDialog({
    @required this.title,
    @required this.body,
    @required this.buttonText,
    @required this.buttonOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        TextButton(
          onPressed: buttonOnPressed,
          child: Text(
            buttonText,
            style: TextStyle(
              color: CColors.orangeTheme,
            ),
          ),
        ),
      ],
    );
  }
}

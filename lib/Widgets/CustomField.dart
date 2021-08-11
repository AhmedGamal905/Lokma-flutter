import 'package:flutter/material.dart';
import 'package:lokma/helpers/constant/Colors.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function validator;
  final TextEditingController controller;
  final bool obscureText;
  CustomTextField({
    @required this.hint,
    @required this.icon,
    @required this.validator,
    @required this.controller,
    @required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        textDirection: TextDirection.ltr,
        cursorColor: CColors.textFelidTheme,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: CColors.textFelidHintTheme,
            fontWeight: FontWeight.w400,
            fontFamily: "SFProText",
            fontStyle: FontStyle.normal,
            fontSize: 14.0,
          ),
          prefixIcon: Icon(
            icon,
            color: CColors.textFelidHintTheme,
          ),
          filled: true,
          fillColor: CColors.textFelidTheme,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: CColors.textFelidTheme,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: CColors.textFelidTheme,
            ),
          ),
          errorStyle: TextStyle(
            color: CColors.orangeTheme,
            fontSize: 12,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: CColors.orangeTheme,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: CColors.textFelidTheme,
            ),
          ),
          contentPadding: EdgeInsets.all(8.0),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: CColors.orangeTheme,
            ),
          ),
        ),
      ),
    );
  }
}

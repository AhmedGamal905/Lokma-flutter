import 'package:flutter/material.dart';
import 'package:lokma/helpers/constant/Colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onTap;
  const CustomButton({@required this.text, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: CColors.orangeTheme,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontFamily: "SFProText",
                  fontStyle: FontStyle.normal,
                  fontSize: 15.0),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class WhiteBoldText extends StatelessWidget {
  const WhiteBoldText({required this.fontSize, required this.text, Key? key})
      : super(key: key);
  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize,
        fontFamily: "Noteworthy-Bold",
      ),
    );
  }

  static TextStyle getStyle(double fontSize) {
    return TextStyle(
      color: Colors.white,
      fontSize: fontSize,
      fontFamily: "Noteworthy-Bold",
    );
  }
}

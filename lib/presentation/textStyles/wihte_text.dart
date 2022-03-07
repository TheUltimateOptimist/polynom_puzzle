import 'package:flutter/material.dart';

class WhiteText extends StatelessWidget {
  const WhiteText({required this.fontSize, required this.text, Key? key})
      : super(key: key);
  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontFamily: "Noteworthy-Light"));
  }
}
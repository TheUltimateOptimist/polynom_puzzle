import 'package:flutter/material.dart';

class BlackBoldText extends StatelessWidget {
  const BlackBoldText({required this.fontSize, required this.text, Key? key})
      : super(key: key);
  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            color: Colors.black,
            fontSize: fontSize,
            fontFamily: "Noteworthy-Bold"));
  }
}
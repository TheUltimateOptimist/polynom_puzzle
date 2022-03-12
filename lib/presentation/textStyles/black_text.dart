import 'package:flutter/material.dart';

class BlackText extends StatelessWidget {
  const BlackText({required this.fontSize, required this.text, this.isUnderlined = false,Key? key})
      : super(key: key);
  final String text;
  final double fontSize;
  final bool isUnderlined;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(decoration: isUnderlined ? TextDecoration.underline : null,
            color: Colors.black,
            fontSize: fontSize,
            fontFamily: "Noteworthy-Light"));
  }

  static TextStyle style(double fontSize){ 
    return TextStyle(color: Colors.black,
            fontSize: fontSize,
            fontFamily: "Noteworthy-Light");}
}
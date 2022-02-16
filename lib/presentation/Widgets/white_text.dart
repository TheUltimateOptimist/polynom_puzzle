import 'package:flutter/material.dart';

class WhiteText extends StatelessWidget {
  final String title;
  final double fontSize;
  const WhiteText({required this.title, required this.fontSize, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: "Noteworthy-Bold",
        color: Colors.white,
        fontSize: fontSize,
      ),
    );
  }
}
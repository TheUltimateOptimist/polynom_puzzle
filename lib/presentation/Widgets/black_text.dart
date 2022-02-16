import 'package:flutter/material.dart';

class BlackText extends StatelessWidget {
  final String title;
  final double fontSize;
  final String fontFamily;
  const BlackText({required this.title, required this.fontSize, this.fontFamily = "Noteworthy-Bold", Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: fontFamily,
        color: Colors.black,
        fontSize: fontSize,
      ),
    );
  }
}

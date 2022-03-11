import 'package:flutter/material.dart';
import 'package:polynom_puzzle/constants/sizes.dart';

class DialogText extends StatelessWidget {
  final String text;
  final Color color;
  const DialogText({required this.text, Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: Sizes.dialogInfoSize(),
        fontFamily: "Noteworthy-Light",
      ),
    );
  }
}

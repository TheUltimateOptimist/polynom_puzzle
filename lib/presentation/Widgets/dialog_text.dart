import 'package:flutter/material.dart';
import 'package:polynom_puzzle/function_colors.dart';

class DialogText extends StatelessWidget {
  final String text;
  const DialogText({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text,
        style: TextStyle(
          color: FunctionColors.three,
          fontSize: 30,
          fontFamily: "Noteworthy-Light",
        ),
      ),
    );
  }
}

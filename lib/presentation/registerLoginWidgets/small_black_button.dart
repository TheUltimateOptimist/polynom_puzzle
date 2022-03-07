import 'package:flutter/material.dart';
import 'package:polynom_puzzle/presentation/Widgets/white_text.dart';

class SmallBlackButton extends StatelessWidget {
  const SmallBlackButton(
      {required this.onPressed, required this.title, Key? key})
      : super(key: key);

  final String title;
  final void Function() onPressed;

  static const double fontSize = 20;
  static const double width = 150;
  static const double height = 40;
  static const double borderRadius = 10;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        child: Container(
            margin: EdgeInsets.only(
              bottom: height / 20,
            ),
            child: WhiteText(fontSize: fontSize, title: title)),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                borderRadius,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

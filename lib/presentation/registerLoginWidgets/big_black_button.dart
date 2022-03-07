import 'package:flutter/material.dart';
import 'package:polynom_puzzle/presentation/textStyles/white_bold_text.dart';

class BigBlackButton extends StatelessWidget {
  const BigBlackButton({required this.onPressed, this.color = Colors.black,this.title = "", this.child,Key? key})
      : super(key: key);

  final String title;
  final void Function() onPressed;
  final Widget? child;
  final Color color;

  static const double fontSize = 25;
  static const double width = 450;
  static const double height = 63;
  static const double borderRadius = 10;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, height: height,
      child: ElevatedButton(
        child: child == null ? WhiteBoldText(fontSize: fontSize, text: title) : child,
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: color,
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

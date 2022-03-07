import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

// ignore: must_be_immutable
class SlideTile extends StatelessWidget {
  final String content;
  final void Function() onPressed;
  final double height;
  final Color color;
  SlideTile(
      {
        required this.content,
        required this.onPressed,
      required this.height,required this.color,

      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
        return SizedBox(width: height, height: height,
          child: TextButton(
            style: ElevatedButton.styleFrom(
              primary: color,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    20,
                  ),
                ),
              ),
            ),
            child: FittedBox(
              child: Math.tex(
                 content,
                textStyle:  TextStyle(
                  color: Colors.white,
                  fontSize: height / 4,
                ),
              ),
            ),
            onPressed: onPressed,
          ),
        );
  }
}
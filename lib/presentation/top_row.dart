import 'package:flutter/material.dart';
import 'package:polynom_puzzle/presentation/pokes.dart';
import 'package:polynom_puzzle/presentation/textStyles/black_bold_text.dart';
import 'package:polynom_puzzle/presentation/textStyles/black_text.dart';

class TopRow extends StatelessWidget {
  final String title;
  final String first;
  final String second;
  final void Function() firstPressed;
  final void Function() secondPressed;
  const TopRow(
      {this.title = "SomeText",
      this.first = "first",
      this.second = "second",
      required this.firstPressed,
      required this.secondPressed,
      Key? key})
      : super(key: key);

  static const double navigationMargin = 30;
  static const double navigationFontSize = 20;
  static const double titleFontSize = 35;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlackBoldText(
          fontSize: titleFontSize,
          text: title,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: firstPressed,
              child: BlackText(
                fontSize: navigationFontSize,
                text: first,
              ),
            ),
            Container(
              width: navigationMargin,
            ),
            TextButton(
              onPressed: secondPressed,
              child: BlackText(
                fontSize: navigationFontSize,
                text: second,
              ),
            ),
            Container(
              width: navigationMargin,
            ),
            Pokes(
              1000,
            ),
          ],
        )
      ],
    );
  }
}

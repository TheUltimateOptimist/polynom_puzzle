import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:polynom_puzzle/presentation/textStyles/black_bold_text.dart';
import 'package:polynom_puzzle/presentation/textStyles/white_bold_text.dart';

class Pokes extends Row {
  static const double textSize = 20;
  static const double spaceBetween = 5;
  Pokes(
    int count, {
    final bool isWhite = false,
  }) : super(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: textSize / 3,
              ),
              child: isWhite
                  ? WhiteBoldText(
                      fontSize: textSize,
                      text: count.toString(),
                    )
                  : BlackBoldText(
                      fontSize: textSize,
                      text: count.toString(),
                    ),
            ),
            Container(
              width: spaceBetween,
            ),
            Container(
              margin: EdgeInsets.only(
                top: textSize / 5,
              ),
              width: textSize,
              height: textSize,
              child: SvgPicture.asset(
                "assets/pictures/poke.svg",
              ),
            ),
          ],
        );
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:polynom_puzzle/function_colors.dart';
import 'package:polynom_puzzle/presentation/registerLoginWidgets/big_black_button.dart';
import 'package:polynom_puzzle/presentation/textStyles/white_bold_text.dart';

class GoogleButton extends BigBlackButton {
  GoogleButton(final void Function() onPressed)
      : super(color: FunctionColors.one,
          onPressed: onPressed,
          child: Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                FontAwesomeIcons.google,
                size: iconSize,
                color: Colors.white,
              ),
              Container(
                width: spaceBetween,
              ),
              Container(margin: EdgeInsets.only(top: BigBlackButton.height/20,),
                child: WhiteBoldText(
                  fontSize: fontSize,
                  text: "Continue with Google",
                ),
              ),
            ],
          ),
        );

  static const double fontSize = 25;
  static const double iconSize = 25;
  static const double spaceBetween = 10;
}

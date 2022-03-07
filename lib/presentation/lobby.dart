import 'dart:math';

import 'package:flutter/material.dart';
import 'package:polynom_puzzle/function_colors.dart';
import 'package:polynom_puzzle/presentation/colored_container.dart';
import 'package:polynom_puzzle/presentation/textStyles/black_text.dart';
import 'package:polynom_puzzle/presentation/textStyles/white_bold_text.dart';
import 'package:polynom_puzzle/presentation/top_row.dart';

import 'container_content.dart';

abstract class Modes {
  static const String singlePlayer = "SinglePlayer";
  static const String multiPlayer = "MultiPlayer";
  static const String withFriend = "Play with friend";
}

abstract class Difficulties {
  static const String linear = "linear";
  static const String quadratic = "quadratic";
  static const String cubic = "cubic";
}

class Lobby extends StatelessWidget {
  const Lobby({Key? key}) : super(key: key);

  static const double subtitleFontSize = 20;
  static const double categoryFontSize = 30;
  static const double difficultyFontSize = 20;
  static const double pageWidth = 1000;
  static const double pageHeight = 600;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            width: pageWidth,
            height: pageHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TopRow(
                  firstPressed: () {},
                  secondPressed: () {},
                  title: "Polynom Puzzle",
                  first: "Rangliste",
                  second: "My Profile",
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlackText(
                      fontSize: subtitleFontSize,
                      text:
                          "Let's go! Prove your math skills solving the Polynom Puzzle in either",
                    ),
                    BlackText(
                      fontSize: subtitleFontSize,
                      text:
                          "Single- or Multiplayer Mode. Or challenge a friend. Just Have fun!",
                    ),
                  ],
                ),
                Row(
                  children: [
                    ColoredContainer(
                      FunctionColors.two,
                      child: ModeContent(
                        Modes.singlePlayer,
                      ),
                    ),
                    ColoredContainer(
                      FunctionColors.one,
                      child: ModeContent(
                        Modes.multiPlayer,
                      ),
                    ),
                    ColoredContainer(
                      FunctionColors.three,
                      child: ModeContent(
                        Modes.withFriend,
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ModeContent extends ContainerContent {
  ModeContent(final String title)
      : super(
          title,
          children: [
            SelectionRow(
              title: Difficulties.linear,
            ),
            SelectionRow(
              title: Difficulties.quadratic,
            ),
            SelectionRow(
              title: Difficulties.cubic,
            ),
          ],
        );
}

class Selecter extends Stack {
  Selecter({
    required final void Function() onPressed,
    final bool isSelected = false,
  }) : super(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: Icon(
                Icons.circle,
                size: Lobby.difficultyFontSize,
                color: Colors.white,
              ),
              onPressed: onPressed,
            ),
            if (isSelected)
              Transform.rotate(
                angle: pi / 4,
                child: Icon(
                  Icons.add,
                  size: Lobby.difficultyFontSize * 2,
                  color: Colors.black,
                ),
              ),
          ],
        );
}

class SelectionRow extends StatelessWidget {
  final String title;

  SelectionRow({
    this.title = "",
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(0, 0),
            padding: EdgeInsets.symmetric(
                horizontal: 0, vertical: Lobby.difficultyFontSize * 0.5),
          ),
          child: WhiteBoldText(
            fontSize: Lobby.difficultyFontSize,
            text: title,
          ),
          onPressed: onPressed,
        ),
        Selecter(
          onPressed: onPressed,
          isSelected: false,
        )
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }

  void onPressed() {
    switch (title) {
      case Difficulties.linear: //do
        break;
      case Difficulties.quadratic: //do
        break;
      case Difficulties.cubic: //do
        break;
      default:
        throw new Exception(
            "ERROR: The mode could not be recognized correctly!");
    }
  }
}

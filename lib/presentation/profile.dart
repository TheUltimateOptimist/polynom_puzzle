import 'package:flutter/material.dart';
import 'package:polynom_puzzle/presentation/container_content.dart';
import 'package:polynom_puzzle/presentation/lobby.dart';
import 'package:polynom_puzzle/presentation/textStyles/black_bold_text.dart';
import 'package:polynom_puzzle/presentation/textStyles/black_text.dart';
import 'package:polynom_puzzle/presentation/textStyles/white_bold_text.dart';
import 'package:polynom_puzzle/presentation/top_row.dart';

import '../function_colors.dart';
import 'Widgets/white_text.dart';
import 'colored_container.dart';

abstract class StatsTitles {
  static const overallGamesPlayed = "Overall Games played: ";
  static const overallGamesWon = "Overall Games won: ";
  static const overallGameLost = "Overall Games lost: ";

  static const gamesPlayed = "Games played: ";
  static const gamesWon = "Games won: ";
  static const gamesLost = "Games lost: ";
}

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            width: Lobby.pageWidth,
            height: Lobby.pageHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopRow(
                  firstPressed: () {},
                  secondPressed: () {},
                  title: "Jonathan",
                  first: "Logout",
                  second: "Rank: #345",
                ),
                Row(
                  children: [
                    StatItem(
                      StatsTitles.overallGamesPlayed,
                      342,
                      onContainer: false,
                    ),
                    StatItem(
                      StatsTitles.overallGamesWon,
                      134,
                      onContainer: false,
                    ),
                    StatItem(
                      StatsTitles.overallGameLost,
                      13,
                      onContainer: false,
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                Row(
                  children: [
                    ColoredContainer(
                      FunctionColors.two,
                      ignorePointer: true,
                      child: ModeContent(
                        Difficulties.linear,
                      ),
                    ),
                    ColoredContainer(
                      FunctionColors.one,
                      ignorePointer: true,
                      child: ModeContent(
                        Difficulties.quadratic,
                      ),
                    ),
                    ColoredContainer(
                      FunctionColors.three,
                      ignorePointer: true,
                      child: ModeContent(
                        Difficulties.cubic,
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

class StatItem extends Row {
  StatItem(
    final String title,
    final int count, {
    final bool onContainer = true,
  }) : super(
          children: [
            if (onContainer)
              WhiteText(
                fontSize: Lobby.subtitleFontSize,
                title: title,
              )
            else
              BlackText(fontSize: Lobby.subtitleFontSize, text: title),
            Container(
              width: Lobby.subtitleFontSize * 0.5,
            ),
            if (onContainer)
              Container(
                margin: EdgeInsets.only(
                  top: Lobby.subtitleFontSize * 0.4,
                ),
                child: WhiteBoldText(
                  fontSize: Lobby.subtitleFontSize,
                  text: count.toString(),
                ),
              )
            else
              Container(
                margin: EdgeInsets.only(
                  top: Lobby.subtitleFontSize * 0.4,
                ),
                child: BlackBoldText(
                  fontSize: Lobby.subtitleFontSize,
                  text: count.toString(),
                ),
              ),
          ],
          mainAxisAlignment: onContainer
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.start,
          mainAxisSize: onContainer ? MainAxisSize.max : MainAxisSize.min,
        );
}

class ModeContent extends ContainerContent {
  ModeContent(
    final String title, {
    final List<int> values = const [
      100,
      99,
      3450,
    ],
  }) : super(
          title,
          children: [
            StatItem(
              StatsTitles.gamesPlayed,
              values[0],
            ),
            StatItem(
              StatsTitles.gamesWon,
              values[1],
            ),
            StatItem(
              StatsTitles.gamesLost,
              values[2],
            ),
          ],
        );
}

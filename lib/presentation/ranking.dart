import 'package:flutter/material.dart';
import 'package:polynom_puzzle/function_colors.dart';
import 'package:polynom_puzzle/presentation/colored_container.dart';
import 'package:polynom_puzzle/presentation/pokes.dart';
import 'package:polynom_puzzle/presentation/textStyles/white_bold_text.dart';
import 'package:polynom_puzzle/presentation/textStyles/wihte_text.dart';

class Ranking extends StatelessWidget {
  const Ranking({Key? key}) : super(key: key);

  static const double entryHeight = 60;
  static const double aroundMargin = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Color.fromRGBO(
            0,
            0,
            0,
            0.95,
          ),
          child: ListView.builder(
              itemCount: 25,
              itemBuilder: (context, index) {
                int rank = index;
                if (rank == 0) return Container();
                late Color color;
                switch (rank) {
                  case 1:
                    color = FunctionColors.one;
                    break;
                  case 2:
                    color = FunctionColors.two;
                    break;
                  case 3:
                    color = FunctionColors.three;
                    break;
                  default:
                    color = Colors.black;
                }
                return Container(
                  margin: EdgeInsets.symmetric(
                    vertical: aroundMargin,
                  ),
                  height: entryHeight,
                  width: MediaQuery.of(context).size.width,
                  child: PlayerEntry(
                    onPressed: () {},
                    color: color,
                    ranking: rank,
                    playerName: "Test Person",
                  ),
                );
              }),
        ),
      ),
    );
  }
}

class PlayerEntry extends ElevatedButton {
  PlayerEntry({
    required final void Function() onPressed,
    final int ranking = 34,
    final String playerName = "Hans Kans",
    final int trophyCount = 1345,
    required final Color color,
  }) : super(
          style: ElevatedButton.styleFrom(
            primary: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                ColoredContainer.cornerRadius * 0.7,
              ),
            ),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: Pokes.textSize * 0.29,
                    ),
                    child: WhiteBoldText(
                      fontSize: Pokes.textSize,
                      text: "#" + ranking.toString(),
                    ),
                  ),
                  Container(
                    width: Pokes.textSize * 0.5,
                  ),
                  WhiteText(
                    fontSize: Pokes.textSize,
                    text: playerName,
                  ),
                ],
              ),
              Pokes(
                trophyCount,
                isWhite: true,
              ),
            ],
          ),
        );
}

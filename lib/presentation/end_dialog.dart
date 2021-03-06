import 'package:flutter/material.dart';
import 'package:polynom_puzzle/constants/sizes.dart';
import 'package:polynom_puzzle/presentation/pokes.dart';

import '../function_colors.dart';
import '../logic/models/game.dart';
import 'Widgets/action_button.dart';
import 'Widgets/dialog_text.dart';
import 'base_dialog.dart';

class EndDialog extends StatelessWidget {
  final String title;
  final String subTitleOne;
  final String subTitleTwo;
  final int? pokesCount;
  final bool hasLost;
  final Game game;

  const EndDialog({
    Key? key,
    required this.game,
    this.title = "",
    this.subTitleOne = "",
    this.subTitleTwo = "",
    this.pokesCount,
    this.hasLost = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseDialog(child: 
      Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: hasLost ? Colors.black : FunctionColors.one,
            fontSize: 45,
            fontFamily: "Noteworthy-Bold",
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DialogText(
              color: hasLost ? FunctionColors.one : FunctionColors.three,
              text: subTitleOne,
            ),
            Container(
              height: 20,
            ),
            DialogText(
              color: hasLost ? FunctionColors.one : FunctionColors.three,
              text: subTitleTwo,
            ),
          ],
        ),
        if (pokesCount != null)
          Pokes(
            trophyCount: pokesCount! < 0
                ? "- " + pokesCount!.abs().toString()
                : "+ " + pokesCount.toString(),
          )
        else
          Container(
            height: Sizes.onMobile ? 30 : 40,
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ActionButton(
              child: Text(
                "Back",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.buttonTextSize(),
                    fontFamily: "Noteworthy-Light"),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Container(
              width: Sizes.onMobile ? 5 : 10,
            ),
            // ActionButton(
            //   onPressed: () async {
            //     late Game newGame;
            //     switch (game.mode) {
            //       case 1:
            //         newGame = Game.singlePlayer(game.difficulty);
            //         break;
            //       case 2:
            //         newGame = await Game.multiPlayer(game.difficulty);
            //         break;
            //       case 3:
            //         newGame = await Game.withFriend(
            //             game.difficulty, Game.generateId());
            //     }
            //     Navigator.pushReplacement(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => Playing(
            //           game: newGame,
            //         ),
            //       ),
            //     );
            //   },
            //   child: WhiteText(
            //     title: "New Game",
            //     fontSize: Sizes.buttonTextSize(),
            //   ),
            // ),
          ],
        ),
      ],),
    );
  }
}

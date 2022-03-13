import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polynom_puzzle/logic/blocs/game_cubit.dart';
import 'package:polynom_puzzle/presentation/Widgets/slide_puzzle.dart';
import 'package:polynom_puzzle/presentation/pokes.dart';
import 'package:polynom_puzzle/presentation/textStyles/black_bold_text.dart';
import 'package:polynom_puzzle/presentation/textStyles/black_text.dart';

import '../../constants/sizes.dart';

class PlayerRow extends StatelessWidget {
  const PlayerRow({Key? key}) : super(key: key);

  static  double marginBetween = 5;
  static  double playerNameSize = 25;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SlidePuzzle.puzzleHeight*Sizes.multiplierStrong,
      child: BlocBuilder<GameCubit, GameState>(
        builder: (context, state) {
          return Column(
            children: [
              PlayerColumn(
                state.game.firstPlayerName,
                state.game.firstPlayerTrophyCount,
              ),
              BlackBoldText(
                fontSize: Sizes.multiplierStrong*25,
                text: "vs.",
              ),
              PlayerColumn(
                state.game.secondPayerName!,
                state.game.secondPlayerTrophyCount!,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          );
        },
      ),
    );
  }
}

class PlayerColumn extends Column {
  PlayerColumn(final String name, final int trophyCount, )
      : super(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlackText(
              fontSize: Sizes.multiplierStrong*PlayerRow.playerNameSize,
              text: name + ":",
            ),
            Container(
              height:  Sizes.multiplierStrong*PlayerRow.marginBetween,
            ),
            Pokes(multiplier: Sizes.multiplierStrong),
          ],
        );
}

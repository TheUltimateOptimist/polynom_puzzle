import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polynom_puzzle/logic/blocs/game_cubit.dart';
import 'package:polynom_puzzle/presentation/Widgets/slide_puzzle.dart';
import 'package:polynom_puzzle/presentation/pokes.dart';
import 'package:polynom_puzzle/presentation/row_column_listView.dart';
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
      height: !Sizes.onMobile ? SlidePuzzle.puzzleHeight*Sizes.multiplierStrong : null,width: Sizes.onMobile ? SlidePuzzle.puzzleHeight*Sizes.multiplierStrong : null,
      child: BlocBuilder<GameCubit, GameState>(
        builder: (context, state) {
          return RowColumnListView(collectionType: Sizes.onMobile ? Collection.row : Collection.column,
            children: [
              PlayerColumn(
                state.game.firstPlayerName,
                state.game.firstPlayerTrophyCount,
              ),
              BlackBoldText(
                fontSize: !Sizes.onMobile ? Sizes.multiplierStrong*25 : 0.9*25,
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
              fontSize: !Sizes.onMobile ? Sizes.multiplierStrong*PlayerRow.playerNameSize : PlayerRow.playerNameSize*0.8,
              text: name + ":",
            ),
            Container(
              height:  !Sizes.onMobile ? Sizes.multiplierStrong*PlayerRow.playerNameSize : 0,
            ),
            Pokes(multiplier: !Sizes.onMobile ? Sizes.multiplierStrong : 0.9, ),
          ],
        );
}

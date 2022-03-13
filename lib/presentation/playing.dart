import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polynom_puzzle/logic/blocs/game_cubit.dart';
import 'package:polynom_puzzle/presentation/Widgets/moves.dart';
import 'package:polynom_puzzle/presentation/Widgets/player_row.dart';
import 'package:polynom_puzzle/presentation/Widgets/slide_puzzle.dart';
import 'package:polynom_puzzle/presentation/Widgets/visualization.dart';
import 'package:polynom_puzzle/presentation/lobby.dart';
import 'package:polynom_puzzle/presentation/responsive_expanded.dart';
import 'package:polynom_puzzle/presentation/row_column_listView.dart';
import 'package:polynom_puzzle/presentation/textStyles/black_text.dart';

import '../constants/sizes.dart';
import '../logic/models/game.dart';

class Playing extends StatelessWidget {
  final Game game;
  const Playing({required this.game, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Sizes.update(context);
    return SafeArea(
      child: Scaffold(
        body: BlocProvider<GameCubit>(
          create: (context) {
            return GameCubit(game);
          },
          child: RowColumnListView(collectionType: Sizes.onMobile ? Collection.column : Collection.row,
            mainAxisAlignment: Sizes.onMobile ? MainAxisAlignment.spaceBetween : MainAxisAlignment.spaceEvenly,
            children: [
              ResponsiveExpanded(applyExpanded: Sizes.onMobile ? true : false,
                child: Column(mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: Sizes.onMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if(!Sizes.onMobile)
                    Moves(
                      fontSize: 25,
                    ),
                    if(Sizes.onMobile && game.mode > 1)
                    PlayerRow(),
                    BlackText(
                        fontSize: Lobby.subtitleFontSize,
                        text: "Match the red onto the black function!"),
                        if(!Sizes.onMobile)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (game.mode > 1) PlayerRow(),
                        if(game.mode > 1)
                        Container(
                          width: 40*Sizes.multiplierStrong,
                        ),
                        SlidePuzzle(),
                      ],
                    ),
                   if(Sizes.onMobile) SlidePuzzle(),
                  ],
                ),
              ),
              Visualization(
                width: Sizes.totalWidth,
                height: Sizes.totalHeight / 2.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

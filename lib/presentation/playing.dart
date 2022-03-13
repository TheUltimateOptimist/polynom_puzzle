import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polynom_puzzle/logic/blocs/game_cubit.dart';
import 'package:polynom_puzzle/presentation/Widgets/moves.dart';
import 'package:polynom_puzzle/presentation/Widgets/player_row.dart';
import 'package:polynom_puzzle/presentation/Widgets/slide_puzzle.dart';
import 'package:polynom_puzzle/presentation/Widgets/visualization.dart';
import 'package:polynom_puzzle/presentation/lobby.dart';
import 'package:polynom_puzzle/presentation/textStyles/black_text.dart';

import '../constants/sizes.dart';
import '../logic/models/game.dart';

class Playing extends StatelessWidget {
  final Game game;
  const Playing({required this.game, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print(height);
    print(width);
    return SafeArea(
      child: Scaffold(
        body: BlocProvider<GameCubit>(
          create: (context) {
            return GameCubit(game);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Moves(
                    fontSize: 25,
                  ),
                  BlackText(
                      fontSize: Lobby.subtitleFontSize,
                      text: "Match the red onto the black function!"),
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
                ],
              ),
              Visualization(
                width: width / 2,
                height: height,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

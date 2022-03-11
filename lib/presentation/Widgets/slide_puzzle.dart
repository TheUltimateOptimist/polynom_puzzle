import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polynom_puzzle/function_colors.dart';
import 'package:polynom_puzzle/logic/blocs/game_cubit.dart';
import 'package:polynom_puzzle/logic/blocs/user_cubit.dart';
import 'package:polynom_puzzle/logic/models/function_part.dart';
import 'package:polynom_puzzle/logic/models/poly_part.dart';
import 'package:polynom_puzzle/logic/models/puzzle.dart';
import 'package:polynom_puzzle/presentation/Widgets/slide_tile.dart';
import 'package:polynom_puzzle/presentation/end_dialog.dart';

class SlidePuzzle extends StatefulWidget {
  const SlidePuzzle({
    Key? key,
  }) : super(key: key);

  static double tileHeight = 90;
  static double tileMargin = 10;
  static double puzzleHeight =
      Puzzle.columnLength * tileHeight + (Puzzle.columnLength - 1) * tileMargin;
  static double puzzleWidth =
      Puzzle.rowLength * tileHeight + (Puzzle.rowLength - 1) * tileMargin;
  static const int animationDuration = 300;

  @override
  State<SlidePuzzle> createState() => _SlidePuzzleState();
}

class _SlidePuzzleState extends State<SlidePuzzle> {
  late Timer t;
@override
  void initState() {
   t = Timer.periodic(Duration(seconds: 2), (timer) {
     context.read<GameCubit>().updateOpponent();
   });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameCubit, GameState>(
      listener: (context, state) {
        if (state.hasWon != null && state.hasWon!) {
          t.cancel();
          context.read<UserCubit>().puzzleFinished(state.game);
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) {
              return EndDialog(
                game: state.game,
                title: state.game.mode == 1 ? "Congratulations!" : "You won!",
                subTitleOne: "You successfully matched the function",
                subTitleTwo: "You're now officially a math geak:)",
                pokesCount: state.game.mode == 1 ? null : state.game.trophyChange(true),
              );
            },
          );
        }
        else if(state.hasWon != null && !state.hasWon!){
          t.cancel();
          context.read<UserCubit>().puzzleFinished(state.game);
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) {
              return EndDialog(game: state.game,
                title: "You lost!",hasLost: true,
                subTitleOne: "You successfully matched the function",
                subTitleTwo: "You're now officially a math geak:)",
                pokesCount: state.game.mode == 1 ? null : state.game.trophyChange(true),
              );
            },
          );
        }
      },
      builder: (context, state) {
        return Container(
          height: SlidePuzzle.puzzleHeight,
          width: SlidePuzzle.puzzleWidth,
          child: Stack(
            children: [
              for (FunctionPart part in state.game.firstPlayerPuzzle.parts)
                AnimatedPositioned(
                  left: part.leftDistance,
                  top: part.topDistance,
                  duration: Duration(
                    milliseconds: SlidePuzzle.animationDuration,
                  ),
                  child: SlideTile(
                    content: ((part as PolyPart).scalar < 0 ? "-" : "+") +
                        part.toString(),
                    color: calculateColor(part, state),
                    onPressed: () {
                      if (state.selectedPart != null) {
                        context.read<GameCubit>().changeTiles(part);
                      } else {
                        context.read<GameCubit>().selectFirst(part);
                      }
                    },
                    height: SlidePuzzle.tileHeight,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Color calculateColor(FunctionPart part, GameState state) {
    if (state.selectedPart != null && state.selectedPart!.id == part.id) {
      return FunctionColors.two;
    }
    if (state.game.firstPlayerPuzzle.isPartOfFunction(part)) {
      return FunctionColors.one;
    }
    return FunctionColors.three;
  }
}

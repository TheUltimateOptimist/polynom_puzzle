import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polynom_puzzle/logic/blocs/game_cubit.dart';

class Moves extends StatelessWidget {
  final double fontSize;
  const Moves({required this.fontSize, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return Text(
          state.game.firstPlayerPuzzle.moves.toString() + " Moves",
          style: TextStyle(
            fontFamily: "Noteworthy-Bold",
            color: const Color(0xfff97068),
            fontSize: fontSize,
          ),
        );
      },
    );
  }
}

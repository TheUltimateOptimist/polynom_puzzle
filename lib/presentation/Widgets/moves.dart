import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polynom_puzzle/logic/blocs/puzzle_cubit.dart';

class Moves extends StatelessWidget {
  final double fontSize;
  const Moves({required this.fontSize, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PuzzleCubit, PuzzleState>(
      builder: (context, state) {
        return Text(
          state.numberOfMoves.toString() + " Moves",
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

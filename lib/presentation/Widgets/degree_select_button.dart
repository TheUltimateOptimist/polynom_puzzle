import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polynom_puzzle/logic/blocs/puzzle_cubit.dart';
import 'package:polynom_puzzle/logic/models/polynomial_puzzle.dart';
import 'package:polynom_puzzle/presentation/Widgets/white_text.dart';

class DegreeSelectButton extends StatelessWidget {
  final int degree;
  const DegreeSelectButton({required this.degree, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PuzzleCubit, PuzzleState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(
            right: 15,
          ),
          child: ElevatedButton(
            onPressed: () {
              final puzzleCubit = context.read<PuzzleCubit>();
              puzzleCubit.selectDegree(
                degree,
              );
            },
            child: WhiteText(
              title: degree.toString(),
              fontSize: 25,
            ),
            style: ElevatedButton.styleFrom(
              primary: (state.puzzle as PolynomialPuzzle).degree == degree
                  ? const Color(0xfff97068)
                  : const Color(
                      0xff57c4e5,
                    ),
              fixedSize: const Size(
                60,
                60,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    20,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

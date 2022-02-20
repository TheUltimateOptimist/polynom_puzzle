import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polynom_puzzle/constants/sizes.dart';
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
        return Container(height: Sizes.buttonHeight(),width: Sizes.buttonHeight(),
          margin:  EdgeInsets.only(
            right: Sizes.onMobile ? 8 : 15,
          ),
          child: TextButton(
            onPressed: () {
              final puzzleCubit = context.read<PuzzleCubit>();
              puzzleCubit.selectDegree(
                degree,
              );
            },
            child: WhiteText(
              title: degree.toString(),
              fontSize: Sizes.degreeTextSize(),
            ),
            style: ElevatedButton.styleFrom(
              primary: (state.puzzle as PolynomialPuzzle).degree == degree
                  ? const Color(0xfff97068)
                  : const Color(
                      0xff57c4e5,
                    ),
              shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    Sizes.onMobile ? 10 : 20,
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

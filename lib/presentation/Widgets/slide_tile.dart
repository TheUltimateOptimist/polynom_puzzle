import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polynom_puzzle/function_colors.dart';
import 'package:polynom_puzzle/logic/blocs/puzzle_cubit.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:polynom_puzzle/logic/models/function_part.dart';
import 'package:polynom_puzzle/logic/models/poly_part.dart';

// ignore: must_be_immutable
class SlideTile extends StatelessWidget {
  final FunctionPart part;
  final double height;
  Color color = FunctionColors.three;
  SlideTile(
      {
      required this.part,
      required this.height,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PuzzleCubit, PuzzleState>(
      builder: (context, state) {
        if(state.puzzle.isPartOfFunction(part)){
          color = FunctionColors.one;
        }
        if(state.selectedPart != null && state.selectedPart!.id == part.id){
          color = FunctionColors.two;
        }
        return SizedBox(width: height, height: height,
          child: TextButton(
            style: ElevatedButton.styleFrom(
              primary: color,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    20,
                  ),
                ),
              ),
            ),
            child: FittedBox(
              child: Math.tex(
                 ((part as PolyPart).scalar < 0 ? "-" : "+") + part.toString(),
                textStyle:  TextStyle(
                  color: Colors.white,
                  fontSize: height / 4,
                ),
              ),
            ),
            onPressed: (){final puzzleCubit = context.read<PuzzleCubit>();
            if(state.selectedPart != null){
              puzzleCubit.changeTiles(part);
            }
            else{
              puzzleCubit.selectFirst(part);
            }},
          ),
        );
      },
    );
  }
}
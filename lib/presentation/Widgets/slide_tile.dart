import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polynom_puzzle/function_colors.dart';
import 'package:polynom_puzzle/logic/blocs/puzzle_cubit.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:polynom_puzzle/logic/models/function_part.dart';
import 'package:polynom_puzzle/logic/models/poly_part.dart';

class SlideTile extends StatelessWidget {
  final FunctionPart part;
  Color color = FunctionColors.two;
  SlideTile(
      {
      required this.part,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PuzzleCubit, PuzzleState>(
      builder: (context, state) {
        if(state.puzzle.isPartOfFunction(part)){
          color = FunctionColors.one;
        }
        else if(state.selectedPart != null && state.selectedPart!.id == part.id){
          color = Colors.black;
        }
        return Container(width: 100, height: 100,margin: const EdgeInsets.all(10,),
          child: ElevatedButton(
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
            child: Math.tex(
               ((part as PolyPart).scalar < 0 ? "-" : "+") + part.toString(),
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 25,
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

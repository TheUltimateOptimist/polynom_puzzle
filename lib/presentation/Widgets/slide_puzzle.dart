import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polynom_puzzle/function_colors.dart';
import 'package:polynom_puzzle/logic/blocs/puzzle_cubit.dart';
import 'package:polynom_puzzle/logic/models/function_part.dart';
import 'package:polynom_puzzle/presentation/Widgets/slide_tile.dart';

class SlidePuzzle extends StatelessWidget {
  const SlidePuzzle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PuzzleCubit, PuzzleState>(
      builder: (context, state) {
        print("hello");
        return Container(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for(List<FunctionPart> partRow in state.puzzle.asTwoDimList()) Row(children: [for(FunctionPart part in partRow) SlideTile(part: part)],)
            // TileRow(functionName: "f(x)", tiles: state.puzzle.getRow(0), color: FunctionColors.one,),
            // TileRow(functionName: "g(x)", tiles: state.puzzle.getRow(1), color: FunctionColors.two,),
            // TileRow(functionName: "h(x)", tiles: state.puzzle.getRow(2), color: FunctionColors.three,),
          ],
        ));
      },
    );
  }
}

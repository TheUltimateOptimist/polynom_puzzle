import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polynom_puzzle/logic/blocs/puzzle_cubit.dart';
import 'package:polynom_puzzle/presentation/Widgets/coordinate_system/coordinate_system_painter.dart';

import 'function_painter.dart';

class CoordinateSystem extends StatelessWidget {
  const CoordinateSystem({Key? key}) : super(key: key);
  static double height = 600;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PuzzleCubit, PuzzleState>(
      builder: (context, state) {
        return SizedBox(
          height: height,
          width: height,
          child: CustomPaint(
            foregroundPainter: FunctionPainter(expectedFunction: state.puzzle.expectedFunction, currentFunction: state.puzzle.getCurrentFunction()),
            size: Size(height, height),
           painter: CoordinateSystemPainter(),
          ),
        );
      },
    );
  }
}

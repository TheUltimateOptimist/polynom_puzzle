import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polynom_puzzle/constants/sizes.dart';
import 'package:polynom_puzzle/logic/blocs/game_cubit.dart';
import 'package:polynom_puzzle/presentation/Widgets/coordinate_system/function_painter.dart';
import 'package:polynom_puzzle/presentation/Widgets/function_name.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../function_colors.dart';

class Visualization extends StatelessWidget {
  final double height;
  final double width;
  const Visualization({required this.width, required this.height, Key? key})
      : super(key: key);

  static  int pixelPerUnit = Sizes.onMobile ? 15 : 20;
  static const double systemMargin = 5;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: BlocBuilder<GameCubit, GameState>(
        builder: (context, state) {
          return Stack(
            alignment: Alignment.center,
            children: [
              SfCartesianChart(
                legend:
                    Legend(isVisible: true, title: LegendTitle(text: "TOT")),
                margin: EdgeInsets.all(
                  systemMargin,
                ),
                primaryXAxis: NumericAxis(
                    interval: 2,
                    crossesAt: 0,
                    minimum: 0 - (width / pixelPerUnit / 2).round().toDouble(),
                    maximum: (width / pixelPerUnit / 2).round().toDouble()),
                primaryYAxis: NumericAxis(
                    interval: 2,
                    crossesAt: 0,
                    minimum: 0 - (height / pixelPerUnit / 2).round().toDouble(),
                    maximum: (height / pixelPerUnit / 2).round().toDouble()),
              ),
               CustomPaint(
                    painter: FunctionPainter(
                      expectedFunction: state.game.firstPlayerPuzzle.expectedFunction,
                      currentFunction: state.game.firstPlayerPuzzle.getCurrentFunction(),
                      opponentFunction: state.game.secondPlayerPuzzle?.getCurrentFunction(),
                    ),
                    size: Size(
                      width - 2*systemMargin,
                      height - 2*systemMargin,
                    ),
            
              ),
              Positioned(left: 20, top: 20,child: FunctionName(
                          color: FunctionColors.one,
                          name: "f(x) = " +
                              state.game.firstPlayerPuzzle.getCurrentFunction().toString()),)
            ],
          );
        },
      ),
    );
  }
}

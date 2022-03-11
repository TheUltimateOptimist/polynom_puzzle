import 'package:flutter/material.dart';
import 'package:polynom_puzzle/function_colors.dart';
import 'package:polynom_puzzle/logic/models/puzzle_function.dart';
import 'package:polynom_puzzle/presentation/Widgets/visualization.dart';

class FunctionPainter extends CustomPainter {
  double opacity = 0.2;
  int numberOfLines = 500;
  late double maxX;
  late double maxY;

  final PuzzleFunction expectedFunction;
  final PuzzleFunction currentFunction;
  final PuzzleFunction? opponentFunction;
  
  Paint functionPaint = Paint()
    ..strokeWidth = 3
    ..strokeCap = StrokeCap.round;
  FunctionPainter(
      {required this.expectedFunction, required this.currentFunction, this.opponentFunction});

  @override
  void paint(Canvas canvas, Size size) {
    maxX = size.width/Visualization.pixelPerUnit/2;
    maxY = size.height/Visualization.pixelPerUnit/2;
    if(opponentFunction != null){
      paintFunction(canvas, size, opponentFunction!, Colors.blue);
    }
    paintFunction(canvas, size, expectedFunction, Colors.black);
    paintFunction(canvas, size, currentFunction, FunctionColors.one);
  }

  void paintFunction(Canvas canvas, Size size,
      PuzzleFunction function, Color color) {
        functionPaint.color = color;
    double distance = size.width / numberOfLines;
    for (int i = 0; i < numberOfLines; i++) {
      double startX = i * distance;
      double startY = toUIY(
            function.getY(
              toFuncX(
                i * distance,
                size,
              ),
            ),
            size,
          );
      double endX = (i + 1) * distance;
      double endY = toUIY(
            function.getY(
              toFuncX(
                (i + 1) * distance,
                size,
              ),
            ),
            size,
          );
      if(endY <= (size.height - Visualization.systemMargin) && startY <= (size.height - Visualization.systemMargin) && endY >= Visualization.systemMargin && startY >= Visualization.systemMargin){
      canvas.drawLine(
        Offset(
          startX,
          startY,
        ),
        Offset(
          endX,
          endY,
        ),
        functionPaint,
      );
      
      }
    }
    print("Hallo");
  }

  double toFuncX(double x, Size size) {
    x = x / (size.width / (maxX * 2));
    x = x - maxX;
    return x;
  }

  double toUIY(double c, Size size) {
    c = c*(-1)*(size.height / (maxY * 2));
    c = c + size.height / 2;
    return c;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

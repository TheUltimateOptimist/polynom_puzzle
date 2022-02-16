import 'package:flutter/material.dart';
import 'package:polynom_puzzle/function_colors.dart';
import 'package:polynom_puzzle/logic/models/puzzle_function.dart';

class FunctionPainter extends CustomPainter {
  double opacity = 0.2;
  int numberOfLines = 10000;
  int maxX = 10;

  final PuzzleFunction expectedFunction;
  final PuzzleFunction currentFunction;
  
  Paint functionPaint = Paint()
    ..strokeWidth = 3
    ..strokeCap = StrokeCap.round;
  FunctionPainter(
      {required this.expectedFunction, required this.currentFunction});

  @override
  void paint(Canvas canvas, Size size) {
    paintFunction(canvas, size, expectedFunction, true);
    paintFunction(canvas, size, currentFunction, false);
  }

  void paintFunction(Canvas canvas, Size size,
      PuzzleFunction function, bool isExpected) {
    double distance = size.width / numberOfLines;
    if (isExpected) {
      functionPaint.color = Colors.black;
    } else {
      functionPaint.color = FunctionColors.one;
    }
    for (int i = 0; i < numberOfLines; i++) {
      canvas.drawLine(
        Offset(
          i * distance,
          toUIY(
            function.getY(
              toFuncX(
                i * distance,
                size,
              ),
            ),
            size,
          ),
        ),
        Offset(
          (i + 1) * distance,
          toUIY(
            function.getY(
              toFuncX(
                (i + 1) * distance,
                size,
              ),
            ),
            size,
          ),
        ),
        functionPaint,
      );
    }
  }

  double toFuncX(double x, Size size) {
    x = x / (size.width / (maxX * 2));
    x = x - maxX;
    return x;
  }

  double toUIY(double c, Size size) {
    c = c*(-1)*(size.width / (maxX * 2));
    c = c + size.width / 2;
    return c;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

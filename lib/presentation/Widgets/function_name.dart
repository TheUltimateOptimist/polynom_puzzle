import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:polynom_puzzle/constants/sizes.dart';

class FunctionName extends StatelessWidget {
  final String name;
  final Color color;
  const FunctionName({required this.color, required this.name, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Math.tex(
        name,
        textStyle: TextStyle(
          color: color,
          fontSize: Sizes.functionTextSize(),
        ),
      ),
    );
  }
}

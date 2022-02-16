import 'dart:math';

import 'package:polynom_puzzle/logic/models/function_part.dart';

class PolyPart extends FunctionPart{
  static const int maxScalar = 5;
  late final int scalar;
  late final int degree;

  PolyPart({required this.scalar, required this.degree, required int id}) : super(id: id);

  PolyPart.random({required int id, required this.degree, canBeZero = true}) : super(id: id){
    late int randScalar;
    do{
      randScalar = Random().nextInt(2*maxScalar + 1) - maxScalar;
    }
    while(!canBeZero && randScalar == 0);
    scalar = randScalar;
  }

  @override
  String toString() {
    String polyPart = scalar.abs().toString();
    switch(degree){
      case 0: polyPart += "";
      break;
      case 1: polyPart += "x";
      break;
      default: polyPart += "x^" + degree.toString();
    }
    return polyPart;
  }

  @override
  double getY(double x) {
    double result = scalar*pow(x, degree).toDouble();
    return result;
  }
}
import 'dart:math';

import 'package:polynom_puzzle/logic/models/function_part.dart';

class PolyPart extends FunctionPart {
  static const int maxScalar = 5;
  late final double scalar;
  late final int degree;

  PolyPart({required this.scalar, required this.degree, required int id})
      : super(id: id);

  PolyPart.random({required int id, required this.degree, canBeZero = true})
      : super(id: id) {
    late double randScalar;
    Random rand = Random();
    do {
      randScalar = (rand.nextInt(2 * maxScalar + 1) - maxScalar).toDouble();
      if (rand.nextInt(2) == 0 && randScalar.abs() > 1) {
        double m = (1 / randScalar) * 10;
        randScalar = m < 0 ? m.floor() / 10 : m.ceil() / 10;
      }
    } while (!canBeZero && randScalar == 0);
    scalar = randScalar;
  }

  @override
  String toString() {
    String polyPart = scalar.abs().toString();
    switch (degree) {
      case 0:
        polyPart += "";
        break;
      case 1:
        polyPart += "x";
        break;
      default:
        polyPart += "x^" + degree.toString();
    }
    return polyPart;
  }

  @override
  double getY(double x) {
    double result = scalar * pow(x, degree).toDouble();
    return result;
  }

  @override
  FunctionPart copyWith(double _leftDistance, double _topDistance) {
    FunctionPart newPart = PolyPart(scalar: scalar, degree: degree, id: id);
    newPart.leftDistance = _leftDistance;
    newPart.topDistance = _topDistance;
    return newPart;
  }

  static PolyPart fromMap(Map<String, dynamic> map) {
    PolyPart result = PolyPart(
      scalar: map["scalar"],
      degree: map["degree"],
      id: map["id"],
    );
    result.leftDistance = map["leftDistance"];
    result.topDistance = map["topDistance"];
    return result;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "scalar": scalar,
      "degree": degree,
      "id": id,
      "leftDistance": leftDistance,
      "topDistance": topDistance,
    };
  }
}

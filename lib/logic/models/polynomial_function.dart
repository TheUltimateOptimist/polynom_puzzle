import 'package:polynom_puzzle/logic/models/poly_part.dart';
import 'package:polynom_puzzle/logic/models/puzzle_function.dart';

class PolynomialFunction extends PuzzleFunction {
  List<PolyPart> polyParts;

  PolynomialFunction({required this.polyParts}) {
    polyParts.sort((a, b) => b.degree.compareTo(a.degree));
  }

  @override
  double getY(double x) {
    double y = 0;
    for (PolyPart polyPart in polyParts) {
      y += polyPart.getY(x);
    }
    return y;
  }

  @override
  String toString() {
    String result = "";
    for (int i = 0; i < polyParts.length; i++) {
      for (int j = i + 1; j < polyParts.length; j++) {
        while (j < polyParts.length &&
            polyParts[j].degree == polyParts[i].degree) {
          polyParts[i] = PolyPart(
            scalar: polyParts[i].scalar + polyParts[j].scalar,
            degree: polyParts[i].degree,
            id: 100,
          );
          polyParts.removeAt(j);
        }
      }
    }
    for (PolyPart polyPart in polyParts) {
      if (polyPart.degree != 0 && polyPart.scalar != 0) {
        if (result.isEmpty) {
          result += polyPart.scalar < 0
              ? ("-" + polyPart.toString())
              : polyPart.toString();
        } else {
          result += polyPart.scalar < 0
              ? (" - " + polyPart.toString())
              : (" + " + polyPart.toString());
        }
      } else if (polyPart.scalar != 0) {
        if (result.isEmpty) {
          result += polyPart.scalar < 0
              ? ("-" + polyPart.toString())
              : polyPart.toString();
        } else {
          result += polyPart.scalar < 0
              ? (" - " + polyPart.toString())
              : (" + " + polyPart.toString());
        }
      }
    }
    return result.isEmpty ? "0" : result;
  }

  @override
  bool equals(PuzzleFunction other) {
    return toString() == other.toString() ? true : false;
  }

  @override
  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> mapList = List.empty(growable: true);
    for (var part in polyParts) {
      mapList.add(part.toMap());
    }
    return {"parts": mapList};
  }

  static PolynomialFunction fromMap(Map<String, dynamic> map) {
    List<PolyPart> parts = List.empty(growable: true);
    List<dynamic> mapList = map["parts"];
    for (int i = 0; i < mapList.length; i++) {
      parts.add(PolyPart.fromMap(mapList[i]));
    }
    return PolynomialFunction(
      polyParts: parts,
    );
  }
}

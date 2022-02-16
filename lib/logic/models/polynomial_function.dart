import 'package:polynom_puzzle/logic/models/poly_part.dart';
import 'package:polynom_puzzle/logic/models/puzzle_function.dart';

class PolynomialFunction extends PuzzleFunction{

  List<PolyPart> polyParts;

  PolynomialFunction({required this.polyParts}){
    polyParts.sort((a, b) => b.degree.compareTo(a.degree));
  }

  @override
  double getY(double x) {
    double y = 0;
    for(PolyPart polyPart in polyParts){
      y += polyPart.getY(x);
    }
    return y;
  }

  @override
  String toString() {
    String result = "";
    for(PolyPart polyPart in polyParts){
      if(polyPart.degree != 0){
        if(result.isEmpty){
          result+=polyPart.scalar < 0 ? ("-" + polyPart.toString()) : polyPart.toString();
        }
        else{
          result+=polyPart.scalar < 0 ? (" - " + polyPart.toString()) : (" + " + polyPart.toString());
        }
      }
    }
    return result.isEmpty ? "0" : result;
  }

  @override
  bool equals(PuzzleFunction other) {
      return toString() == other.toString() ? true : false;
  }
}
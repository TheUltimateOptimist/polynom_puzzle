import 'package:polynom_puzzle/logic/models/function_part.dart';
import 'package:polynom_puzzle/logic/models/polynomial_function.dart';
import 'package:polynom_puzzle/logic/models/poly_part.dart';
import 'package:polynom_puzzle/logic/models/puzzle.dart';
import 'package:polynom_puzzle/logic/models/puzzle_function.dart';

class PolynomialPuzzle extends Puzzle {

  final int degree;

  PolynomialPuzzle.random(
      {required this.degree, 
       }
      ) : super(parts: []){
        parts = _getRandomParts();
        expectedFunction = getCurrentFunction();
        parts.shuffle();
      }

    List<FunctionPart> _getRandomParts(){
      List<FunctionPart> randomParts = List.empty(growable: true);
      for(int i = 0; i < Puzzle.dimensions; i++){
        for(int j = 0; j < Puzzle.dimensions; j++){
          randomParts.add(PolyPart.random(id: i*Puzzle.dimensions + j,degree: Puzzle.dimensions - 1- j, canBeZero: j == 0 ? false : true),);
        }
      }
      return randomParts;
    }

  @override
  PuzzleFunction getCurrentFunction() {
    return PolynomialFunction(polyParts: parts.sublist(0, degree + 1) as List<PolyPart>);
  }

  @override
  bool isSolved() {
    if(getCurrentFunction().equals(expectedFunction)){
      return true;
    }
    return false;
  }

  @override
  bool isPartOfFunction(FunctionPart part) {
    for(int i = 0; i < degree + 1; i++){
      if(parts[i].id == part.id){
        return true;
      }
    }
    return false;
  }
}

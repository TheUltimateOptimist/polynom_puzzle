import 'dart:math';

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
        do{_randomize();}while(isSolved());
      }

    List<FunctionPart> _getRandomParts(){
      List<FunctionPart> randomParts = List.empty(growable: true);
      for(int i = 0; i < Puzzle.dimensions; i++){
        for(int j = 0; j < Puzzle.dimensions; j++){
          randomParts.add(PolyPart.random(id: i*Puzzle.dimensions + j,degree: degree - j >= 0 ? degree - j : randomDegree(), canBeZero: j == 0 ? false : true),);
        }
      }
      return randomParts;
    }

    int randomDegree(){
      Random rand = Random();
      return rand.nextInt(degree + 1);
    }

  @override
  PuzzleFunction getCurrentFunction() {
    List<PolyPart> functionParts = List.empty(growable: true);
    for(int i = 0; i < degree + 1; i++){
      functionParts.add(parts[i] as PolyPart);
    }
    return PolynomialFunction(polyParts: functionParts);
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

  void _randomize(){
    for(int i = 0; i < Puzzle.dimensions; i++){
      List<FunctionPart> shuffleList = List.empty(growable: true);
      for(int j = 0; j < parts.length; j+=Puzzle.dimensions){
        shuffleList.add(parts[j + i]);
      }
      shuffleList.shuffle();
      for(int j = 0; j < parts.length; j+=Puzzle.dimensions){
        parts[j + i] = shuffleList[(j/Puzzle.dimensions).floor()];
      }
    }
  }
}

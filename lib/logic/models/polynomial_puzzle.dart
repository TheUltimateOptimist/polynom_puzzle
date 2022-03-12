import 'dart:math';

import 'package:polynom_puzzle/logic/models/function_part.dart';
import 'package:polynom_puzzle/logic/models/polynomial_function.dart';
import 'package:polynom_puzzle/logic/models/poly_part.dart';
import 'package:polynom_puzzle/logic/models/puzzle.dart';
import 'package:polynom_puzzle/logic/models/puzzle_function.dart';
import 'package:polynom_puzzle/presentation/Widgets/slide_puzzle.dart';

class PolynomialPuzzle extends Puzzle {
  final int degree;

  PolynomialPuzzle({
    required this.degree,
    required List<FunctionPart> parts,
    int moves = 0,
  }) : super(
          parts: parts,
          moves: moves,
        );

  PolynomialPuzzle.random({
    required this.degree,
  }) : super(parts: []) {
    parts = _getRandomParts();
    _initializePositions();
    expectedFunction = getCurrentFunction();
    do {
      _randomize();
    } while (isSolved());
  }

  List<FunctionPart> _getRandomParts() {
    List<FunctionPart> randomParts = List.empty(growable: true);
    for (int i = 0; i < Puzzle.columnLength; i++) {
      for (int j = 0; j < Puzzle.rowLength; j++) {
        randomParts.add(
          PolyPart.random(
              id: i * Puzzle.rowLength + j,
              degree: degree - j >= 0 ? degree - j : randomDegree(),
              canBeZero: j == 0 ? false : true),
        );
      }
    }
    return randomParts;
  }

  int randomDegree() {
    Random rand = Random();
    return rand.nextInt(degree + 1);
  }

  @override
  PuzzleFunction getCurrentFunction() {
    List<PolyPart> functionParts = List.empty(growable: true);
    for (int i = 0; i < parts.length; i++) {
      if (isPartOfFunction(parts[i])) {
        functionParts.add(parts[i] as PolyPart);
      }
    }
    return PolynomialFunction(polyParts: functionParts);
  }

  // @override
  // PuzzleFunction getExpectedFunction() {
  //   List<PolyPart> functionParts = List.empty(growable: true);
  //   for (int i = 0; i < degree + 1; i++) {
  //       functionParts.add(parts[i] as PolyPart);

  //   }
  //   return PolynomialFunction(polyParts: functionParts);
  // }

  @override
  bool isSolved() {
    if (getCurrentFunction().equals(expectedFunction)) {
      return true;
    }
    return false;
  }

  @override
  bool isPartOfFunction(FunctionPart part) {
    if (part.topDistance == 0 &&
        part.leftDistance <=
            degree * (SlidePuzzle.tileHeight + SlidePuzzle.tileMargin)) {
      return true;
    }
    return false;
  }

  void _randomize() {
    for (int i = 0; i < Puzzle.columnLength; i++) {
      List<FunctionPart> shuffleList = List.empty(growable: true);
      for (int j = 0; j < parts.length; j += Puzzle.rowLength) {
        shuffleList.add(parts[j + i]);
      }
      shuffleList.shuffle();
      for (int j = 0; j < parts.length; j += Puzzle.rowLength) {
        parts[j + i] = shuffleList[(j / Puzzle.rowLength).floor()];
      }
    }
    _initializePositions();
  }

  void _initializePositions() {
    for (int i = 0; i < parts.length; i++) {
      int x = i % Puzzle.rowLength;
      int y = (i / Puzzle.columnLength).floor();
      parts[i].leftDistance =
          x * (SlidePuzzle.tileHeight + SlidePuzzle.tileMargin);
      parts[i].topDistance =
          y * (SlidePuzzle.tileHeight + SlidePuzzle.tileMargin);
    }
  }

  @override
  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> newParts = List.empty(growable: true);
    for (FunctionPart part in parts) {
      newParts.add(part.toMap());
    }
    return {
      "expectedFunction": expectedFunction.toMap(),
      "degree": degree,
      "parts": newParts,
      "moves": moves,
    };
  }

  static PolynomialPuzzle fromMap(Map<String, dynamic> map) {
    List<dynamic> mapParts = map["parts"];
    List<FunctionPart> parts = List.empty(growable: true);
    for (int i = 0; i < mapParts.length; i++) {
      parts.add(PolyPart.fromMap(mapParts[i]));
    }
    PolynomialPuzzle result = PolynomialPuzzle(
      degree: map["degree"],
      parts: parts,
      moves: map["moves"],
    );
    result.expectedFunction =
        PolynomialFunction.fromMap(map["expectedFunction"]);
    return result;
  }
}

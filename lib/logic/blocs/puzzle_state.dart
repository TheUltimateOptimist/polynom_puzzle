part of 'puzzle_cubit.dart';

class PuzzleState{
  final Puzzle puzzle;
  final FunctionPart? selectedPart;
  final int numberOfMoves;

  PuzzleState({required this.puzzle, this.selectedPart, required this.numberOfMoves}){
    print("hallo");
  }
}
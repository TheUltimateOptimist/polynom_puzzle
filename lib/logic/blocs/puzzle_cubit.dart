import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polynom_puzzle/logic/models/function_part.dart';
import 'package:polynom_puzzle/logic/models/polynomial_puzzle.dart';
import 'package:polynom_puzzle/logic/models/puzzle.dart';

part 'puzzle_state.dart';

class PuzzleCubit extends Cubit<PuzzleState> {
  PuzzleCubit()
      : super(
          PuzzleState(
            puzzle: PolynomialPuzzle.random(
              degree: 2
            ),
            numberOfMoves: 0,
          ),
        );

  void selectFirst(FunctionPart part) {
    emit(
      PuzzleState(
        puzzle: state.puzzle,
        selectedPart: part,
        numberOfMoves: state.numberOfMoves,
      ),
    );
  }

  void changeTiles(FunctionPart secondTile) {
    state.puzzle.changeParts(state.selectedPart!, secondTile);
    emit(
      PuzzleState(
        puzzle: state.puzzle,
        numberOfMoves: state.numberOfMoves + 1,
      ),
    );
  }

  void selectDegree(int degree) {
    emit(
      PuzzleState(
        puzzle: PolynomialPuzzle.random(
          degree: degree,
        ),
        numberOfMoves: 0,
      ),
    );
  }

  void shuffle() {
    emit(
      PuzzleState(
        puzzle: PolynomialPuzzle.random(
          degree: (state.puzzle as PolynomialPuzzle).degree,
        ),
        numberOfMoves: 0,
      ),
    );
  }
}

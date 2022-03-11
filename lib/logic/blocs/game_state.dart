part of 'game_cubit.dart';

class GameState {
  Game game;
  FunctionPart? selectedPart;
  bool? hasWon;

  GameState(
      {required this.game, this.selectedPart, this.hasWon});
}

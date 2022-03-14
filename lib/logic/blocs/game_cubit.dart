import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polynom_puzzle/logic/models/backEnd.dart';
import 'package:polynom_puzzle/logic/models/function_part.dart';
import 'package:polynom_puzzle/logic/models/game.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit(Game game)
      : super(
          GameState(game: game),
        );

  void selectFirst(FunctionPart part) {
    emit(
      GameState(
        game: state.game,
        selectedPart: part,
        hasWon: state.hasWon,
      ),
    );
  }

  void changeTiles(FunctionPart secondTile) {
    state.game.firstPlayerPuzzle.changeParts(state.selectedPart!, secondTile);
    if (state.game.mode > 1) {
      if (state.game.firstPlayerPuzzle.isSolved()) {
        state.game.status = 3;
        BackEnd().updateGameField(
            {"status": 3, "firstPlayerPuzzle": state.game.firstPlayerPuzzle.toMap()},
            state.game.docId!);
        emit(
          GameState(
            game: state.game,
            hasWon: true,
          ),
        );
      } else {
        state.game.syncOwnPuzzle();

        emit(
          GameState(
            game: state.game,
            hasWon: state.hasWon,
          ),
        );
      }
    }
    else{
      if(state.game.firstPlayerPuzzle.isSolved()){
        state.game.status = 3;
        emit(GameState(game: state.game, hasWon: true,),);
      }
      else{
        emit(GameState(game: state.game, hasWon: state.hasWon,),);
      }
    }
  }

  Future<void> updateOpponent() async {
    Timer t = Timer.periodic(Duration(seconds: 3,), (timer) async{
      if(state.game.mode > 1){
    await state.game.syncOpponentPuzzle();
    print("Synced");
    print(state.game.secondPlayerPuzzle!.getCurrentFunction().toString());
    if (state.game.secondPlayerPuzzle!.isSolved()) {
      emit(
        GameState(
          game: state.game,
          hasWon: false,
        ),
      );
    } else {
      emit(
        GameState(
          game: state.game,
          hasWon: state.hasWon,
          selectedPart: state.selectedPart,
        ),
      );
    }
  }
    });
    
}}

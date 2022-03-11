import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polynom_puzzle/logic/blocs/user_state.dart';
import 'package:polynom_puzzle/logic/models/backEnd.dart';
import 'package:polynom_puzzle/logic/models/game.dart';
import 'package:polynom_puzzle/logic/models/user.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit()
      : super(
          UserState(
            PuzzleUser(),
          ),
        );

  Future<void> singlePlayerDifficultieSelected(String difficulty) async {
    await state.user.setSinglePlayerDifficultie(difficulty);
    emit(
      UserState(
        state.user,
      ),
    );
  }

  Future<void> multiPlayerDifficultieSelected(String difficulty) async {
    await state.user.setMultiPlayerDifficultie(difficulty);
    emit(
      UserState(
        state.user,
      ),
    );
  }

  Future<void> withFriendDifficultieSelected(String difficulty) async {
    await state.user.setWithFriendDifficultie(difficulty);
    emit(
      UserState(
        state.user,
      ),
    );
  }

  Future<void> loginWithGoogle() async {
    await state.user.loginWithGoogle();
    emit(
      UserState(
        state.user,
      ),
    );
  }

  Future<void> login(String email, String password) async {
    await state.user.login(email, password);
    emit(
      UserState(
        state.user,
      ),
    );
  }

  Future<void> register(String email, String userName, String password) async {
    await state.user.register(email, userName, password);
    emit(
      UserState(
        state.user,
      ),
    );
  }

  Future<void> logout() async {
    await state.user.logout();
    emit(
      UserState(
        state.user,
      ),
    );
  }

  Future<void> loginAsGuest() async {
    await state.user.loginAsGuest();
    emit(
      UserState(
        state.user,
      ),
    );
  }

  Future<void> puzzleFinished(Game game) async {
    if (game.mode > 1) {
      late final int newTrophyCount;
      if (game.firstPlayerPuzzle.isSolved()) {
        newTrophyCount = state.user.trophyCount + game.trophyChange(true);
        switch (game.difficulty) {
          case 1:
            state.user.stats.linearGamesWon++;
            break;
          case 2:
            state.user.stats.quadraticGamesWon++;
            break;
          case 3:
            state.user.stats.quadraticGamesWon++;
        }
      state.user.stats.cubicGamesWon++;
      } else {
        switch (game.difficulty) {
          case 1:
            state.user.stats.linearGamesLost++;
            break;
          case 2:
            state.user.stats.quadraticGamesLost++;
            break;
          case 3:
            state.user.stats.cubicGamesLost++;
        }
        state.user.stats.overallGamesLost++;
        newTrophyCount = state.user.trophyCount + game.trophyChange(false);
      }
      state.user.trophyCount = newTrophyCount;
      await BackEnd().updateUserField("trophyCount", newTrophyCount);
    }

    switch (game.difficulty) {
      case 1:
        state.user.stats.linearGamesPlayed++;
        break;
      case 2:
        state.user.stats.quadraticGamesPlayed++;
        break;
      case 3:
        state.user.stats.cubicGamesPlayed++;
    }
    state.user.stats.overallGamesPlayed++;
    await BackEnd().updateUserField("stats", state.user.stats.toMap());
    emit(
      UserState(
        state.user,
      ),
    );
  }
}

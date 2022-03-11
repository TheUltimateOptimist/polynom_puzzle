import 'dart:async';
import 'dart:math';

import 'package:polynom_puzzle/logic/models/polynomial_puzzle.dart';
import 'package:polynom_puzzle/logic/models/puzzle.dart';
import 'package:polynom_puzzle/logic/models/user.dart';

import 'backEnd.dart';

class Game {
  final int mode;
  final int difficulty;
  int status;
  final String firstPlayerName;
  String? secondPayerName;
  final int firstPlayerTrophyCount;
  int? secondPlayerTrophyCount;
  final int gameId;
  Puzzle firstPlayerPuzzle;
  Puzzle? secondPlayerPuzzle;
  String? docId;

  Game({
    required this.mode,
    required this.difficulty,
    required this.status,
    required this.firstPlayerName,
    required this.firstPlayerTrophyCount,
    this.secondPayerName,
    this.secondPlayerTrophyCount,
    required this.firstPlayerPuzzle,
    this.secondPlayerPuzzle,
    required this.gameId,
    this.docId,
  });

  Map<String, dynamic> toMap() {
    return {
      "mode": mode,
      "difficulty": difficulty,
      "status": status,
      "firstPlayerName": firstPlayerName,
      "firstPlayerTrophyCount": firstPlayerTrophyCount,
      "secondPlayerName": secondPayerName,
      "secondPlayerTrophyCount": secondPlayerTrophyCount,
      "gameId": gameId,
      "firstPlayerPuzzle": firstPlayerPuzzle.toMap(),
      "secondPlayerPuzzle": secondPlayerPuzzle?.toMap(),
    };
  }

  static Game fromMap(Map<String, dynamic> map) {
    return Game(
      mode: map["mode"],
      difficulty: map["difficulty"],
      status: map["status"],
      firstPlayerName: map["firstPlayerName"],
      firstPlayerTrophyCount: map["firstPlayerTrophyCount"],
      secondPayerName: map["secondPlayerName"],
      secondPlayerTrophyCount: map["secondPlayerTrophyCount"],
      firstPlayerPuzzle: PolynomialPuzzle.fromMap(map["firstPlayerPuzzle"]),
      secondPlayerPuzzle: PolynomialPuzzle.fromMap(map["secondPlayerPuzzle"]),
      gameId: map["gameId"],
    );
  }

  static Game singlePlayer(int difficulty) {
    return Game(
      mode: 1,
      difficulty: difficulty,
      firstPlayerName: PuzzleUser().name,
      firstPlayerTrophyCount: PuzzleUser().trophyCount,
      firstPlayerPuzzle: PolynomialPuzzle.random(
        degree: difficulty,
      ),
      gameId: 1,
      status: 2,
    );
  }

  static Future<Game> multiPlayer(int difficulty) async {
    PolynomialPuzzle puzzle = PolynomialPuzzle.random(degree: difficulty);
    Game game = Game(
      mode: 2,
      difficulty: difficulty,
      firstPlayerName: PuzzleUser().name,
      firstPlayerTrophyCount: PuzzleUser().trophyCount,
      status: 1,
      firstPlayerPuzzle: puzzle,
      secondPlayerPuzzle: puzzle,
      gameId: 1,
    );
    return await BackEnd().getMultiPlayerGame(game);
  }

  static Future<Game> withFriend(int difficulty, int? gameId) async{
    if(gameId != null){
    PolynomialPuzzle puzzle = PolynomialPuzzle.random(degree: difficulty);
    Game game = Game(mode: 3, difficulty: difficulty, firstPlayerName: PuzzleUser().name, firstPlayerTrophyCount: PuzzleUser().trophyCount, status: 1, firstPlayerPuzzle: puzzle, secondPlayerPuzzle: puzzle, gameId: gameId, );
    return await BackEnd().getWithFriendGame(game);
    }
    else{
      return await BackEnd().getWithFriendGame(null);
    }
  }

  static int generateId() {
    Random rand = Random();
    return rand.nextInt(90000001) + 10000000;
  }

  Future<void> syncOpponentPuzzle() async{
   Game updatedGame =  await BackEnd().getGameById(docId!);
   secondPlayerPuzzle = updatedGame.secondPlayerPuzzle;
   status = updatedGame.status;

  }

  Future<void> syncOwnPuzzle() async{
    await BackEnd().updateGameField({"firstPlayerPuzzle": firstPlayerPuzzle}, docId!);
  }

  int trophyChange(bool hasWon){
    if(hasWon && firstPlayerTrophyCount > 2000){
      return _getAmount(firstPlayerTrophyCount);
    }
    else if(hasWon){
      return 25;
    }
    if(!hasWon && firstPlayerTrophyCount < 2000){
      return 0-_getAmount(firstPlayerTrophyCount);
    }
    else if(!hasWon){
      return -25;
    }
    return 0;
  }

  int _getAmount(int x){
    int result = (30000*(1/(500*sqrt(2*pi)))*pow(e, -(((x - 2000)*(x - 2000))/(2*500*500)))).round();
    if(result == 0){
      return 1;
    }
    return result;
  }
}

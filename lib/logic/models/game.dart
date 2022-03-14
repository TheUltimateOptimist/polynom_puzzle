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
  final String firstPlayerName_;
  String? secondPlayerName_;
  final int firstPlayerTrophyCount_;
  int? secondPlayerTrophyCount_;
  final int gameId;
  Puzzle firstPlayerPuzzle_;
  Puzzle? secondPlayerPuzzle_;
  String? docId;
  int? lastUpdate;
  bool isInverted;

  Game({
    required this.mode,
    required this.difficulty,
    required this.status,
    required this.firstPlayerName_,
    required this.firstPlayerTrophyCount_,
    this.secondPlayerName_,
    this.secondPlayerTrophyCount_,
    required this.firstPlayerPuzzle_,
    this.secondPlayerPuzzle_,
    required this.gameId,
    this.docId,
    this.lastUpdate,
    this.isInverted = false,
  });

  String get firstPlayerName{
    return isInverted ? secondPlayerName_! : firstPlayerName_;
  }

  String? get secondPlayerName{
    return isInverted ? firstPlayerName_ : secondPlayerName_;
  }

  int get firstPlayerTrophyCount{
    return isInverted ? secondPlayerTrophyCount_! : firstPlayerTrophyCount_;
  }

  int? get secondPlayerTrophyCount{
    return isInverted ? firstPlayerTrophyCount_ : secondPlayerTrophyCount_;
  }

  Puzzle get firstPlayerPuzzle{
    return isInverted ? secondPlayerPuzzle_! : firstPlayerPuzzle_;
  }

  Puzzle? get secondPlayerPuzzle{
    return isInverted ? firstPlayerPuzzle_ : secondPlayerPuzzle_;
  }

  set firstPlayerTrophyCount(int count){
    if(isInverted){
      secondPlayerTrophyCount_ = count;
    }
  }

  set firstPlayerName(String name){
    if(isInverted){
      secondPlayerName_ = name;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      "mode": mode,
      "difficulty": difficulty,
      "status": status,
      "firstPlayerName": firstPlayerName,
      "firstPlayerTrophyCount": firstPlayerTrophyCount,
      "secondPlayerName": secondPlayerName,
      "secondPlayerTrophyCount": secondPlayerTrophyCount,
      "gameId": gameId,
      "firstPlayerPuzzle": firstPlayerPuzzle.toMap(),
      "secondPlayerPuzzle": secondPlayerPuzzle?.toMap(),
      "lastUpdate": lastUpdate,
    };
  }

  static Game fromMap(Map<String, dynamic> map) {
    return Game(
      mode: map["mode"],
      difficulty: map["difficulty"],
      status: map["status"],
      firstPlayerName_: map["firstPlayerName"],
      firstPlayerTrophyCount_: map["firstPlayerTrophyCount"],
      secondPlayerName_: map["secondPlayerName"],
      secondPlayerTrophyCount_: map["secondPlayerTrophyCount"],
      firstPlayerPuzzle_: PolynomialPuzzle.fromMap(map["firstPlayerPuzzle"]),
      secondPlayerPuzzle_: PolynomialPuzzle.fromMap(map["secondPlayerPuzzle"]),
      gameId: map["gameId"],
      lastUpdate: map["lastUpdate"],
    );
  }

  static Game singlePlayer(int difficulty) {
    return Game(
      mode: 1,
      difficulty: difficulty,
      firstPlayerName_: PuzzleUser().name,
      firstPlayerTrophyCount_: PuzzleUser().trophyCount,
      firstPlayerPuzzle_: PolynomialPuzzle.random(
        degree: difficulty,
      ),
      gameId: 1,
      status: 2,
    );
  }

  static Future<Game?> multiPlayer(int difficulty) async {
    PolynomialPuzzle puzzle = PolynomialPuzzle.random(degree: difficulty);
    Game game = Game(
      mode: 2,
      difficulty: difficulty,
      firstPlayerName_: PuzzleUser().name,
      firstPlayerTrophyCount_: PuzzleUser().trophyCount,
      status: 1,
      firstPlayerPuzzle_: puzzle,
      secondPlayerPuzzle_: puzzle,
      gameId: 1,
    );
    return await BackEnd().getMultiPlayerGame(game);
  }

  static Future<Game?> withFriend(int difficulty, int gameId, bool isNew) async{
    if(isNew){
    PolynomialPuzzle puzzle = PolynomialPuzzle.random(degree: difficulty);
    Game game = Game(mode: 3, difficulty: difficulty, firstPlayerName_: PuzzleUser().name, firstPlayerTrophyCount_: PuzzleUser().trophyCount, status: 1, firstPlayerPuzzle_: puzzle, secondPlayerPuzzle_: puzzle, gameId: gameId, );
    return await BackEnd().getWithFriendGame(game, null);
    }
    else{
      return await BackEnd().getWithFriendGame(null, gameId);
    }
  }

  static int generateId() {
    Random rand = Random();
    return rand.nextInt(90000001) + 10000000;
  }

  Future<void> syncOpponentPuzzle() async{
Game updatedGame =  await BackEnd().getGameById(docId!);
   secondPlayerPuzzle_ = updatedGame.secondPlayerPuzzle;
   status = updatedGame.status;
    
  }

  Future<void> syncOwnPuzzle() async{
    if(isInverted){
      await BackEnd().updateGameField({"secondPlayerPuzzle": secondPlayerPuzzle_!.toMap()}, docId!);
    }
    else{
    await BackEnd().updateGameField({"firstPlayerPuzzle": firstPlayerPuzzle_.toMap()}, docId!);}
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

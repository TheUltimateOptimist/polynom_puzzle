import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:polynom_puzzle/logic/models/game.dart';
import 'package:polynom_puzzle/logic/models/user.dart';

class BackEnd{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference users;
  late CollectionReference games;

  BackEnd._privateConstructor();
  static final BackEnd _instance = BackEnd._privateConstructor();
  factory BackEnd() => _instance;

void initialize(){
  users = firestore.collection("users");
  games = firestore.collection("games");
}

Future<int> getRank(int trophyCount) async{
  var playersAbove = await users.where("trophyCount", isGreaterThan: trophyCount).get();
  return playersAbove.size + 1;
}

Future<Map<String, dynamic>> getUser() async{
  return (await users.doc(PuzzleUser().user!.uid).get()).data() as Map<String, dynamic>;
}

Future<void> updateUserField(String field, dynamic newValue)async{
  print(PuzzleUser().user);
  if(!PuzzleUser().user!.isAnonymous){
    await users.doc(PuzzleUser().user!.uid).update({field: newValue});
  }
}

Future<void> addUser(Map<String, dynamic> user) async{
await users.doc(PuzzleUser().user!.uid).set(user);
}

Future<List<Map<String, dynamic>>> getRankList() async{
   var rankList =  await users.orderBy("trophyCount", descending: true).limit(100).get();
   List<Map<String, dynamic>> result = List.empty(growable: true);
   for(var doc in rankList.docs){
     result.add(doc.data() as Map<String, dynamic>);
   }
   return result;
}

Future<Game> getMultiPlayerGame(Game game) async{
  var docs  = (await games.where("status", isEqualTo: 1).where("mode", isEqualTo: game.mode).where("difficulty", isEqualTo: game.difficulty).where("firstPlayerTrophyCount", isLessThan: PuzzleUser().trophyCount + 200).where("firstPlayerTrophyCount", isGreaterThan: PuzzleUser().trophyCount - 200).limit(1).get()).docs;
  if(docs.length == 0){
   return await _getNewGame(game);
  }
  else{
    return await _getExistingGame(docs);
  }
}

Future<Game> getWithFriendGame(Game? game) async{
  if(game != null){
    return await _getNewGame(game);
  }
  else{
    var docs = (await games.where("gameId", isEqualTo: game!.gameId).limit(1).get()).docs;
    if(docs.length == 0){
      throw Exception("No Game found");
    }
    return _getExistingGame(docs);
  }
}

Future<Game> getGameById(String gameId) async{
  return Game.fromMap((await games.doc(gameId).get()).data() as Map<String, dynamic>);
}

Future<String> postGame(Game game) async{
  return (await games.add(game.toMap())).id;
}

Future<Game> _getNewGame(Game game) async{
String docId = await postGame(game);
    while(true){
      await Future.delayed(Duration(seconds: 3,),);
      Game updatedGame = await getGameById(docId);
      if(updatedGame.status == 2){
        updatedGame.docId = docId;
        return updatedGame;
      }
    }
}

Future<Game> _getExistingGame(List<QueryDocumentSnapshot<Object?>> docs) async{
Game updatedGame = Game.fromMap(docs[0].data() as Map<String, dynamic>);
    updatedGame.secondPayerName = PuzzleUser().name;
    updatedGame.secondPlayerTrophyCount = PuzzleUser().trophyCount;
    updatedGame.docId = docs[0].id;
    updatedGame.status = 2;
    await games.doc(docs[0].id).set(updatedGame.toMap());
    return updatedGame;
}

Future<void> updateGameField(Map<String, dynamic> newValues, String docId) async{
  await games.doc(docId).update(newValues);
}
}
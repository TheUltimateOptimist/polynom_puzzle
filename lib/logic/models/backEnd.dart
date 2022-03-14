import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:polynom_puzzle/logic/models/game.dart';
import 'package:polynom_puzzle/logic/models/user.dart';
import 'package:polynom_puzzle/presentation/finding_opponent_dialog.dart';

class BackEnd{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference users;
  late CollectionReference games;
  int? rank;
  DateTime? lastUpdate;

  BackEnd._privateConstructor();
  static final BackEnd _instance = BackEnd._privateConstructor();
  factory BackEnd() => _instance;

void initialize(){
  users = firestore.collection("users");
  games = firestore.collection("games");
}

Future<int> getRank(int trophyCount) async{
  if(lastUpdate == null || DateTime.now().difference(lastUpdate!).inSeconds > 10){
  var playersAbove = await users.where("trophyCount", isGreaterThan: trophyCount).get();
  lastUpdate = DateTime.now();
  rank = playersAbove.size + 1;
  }
  return rank!;
}

Future<Map<String, dynamic>> getUser() async{
  return (await users.doc(PuzzleUser().user!.uid).get()).data() as Map<String, dynamic>;
}

Future<void> updateUserField(String field, dynamic newValue)async{
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
     Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
     if(map["email"] != PuzzleUser().user!.email) {
       map["isCurrentUser"] = false;
     result.add(map);}
   }
   int index = result.indexWhere((element) => element["trophyCount"] <= PuzzleUser().trophyCount);
    Map<String, dynamic> userMap = PuzzleUser().toMap();
    userMap["isCurrentUser"] = true;
   if(index >=0){
   result.insert(index, userMap);
   result = _withRanks(result);
   }
   else{
     result = _withRanks(result);
     userMap["rank"] = await getRank(userMap["trophyCount"]);
     result.add(userMap);
   }
   return result;
}

List<Map<String, dynamic>> _withRanks(List<Map<String, dynamic>> list){
  for(int i = 0; i < list.length; i++){
    list[i]["rank"] = i + 1;
  }
  return list;
}

Future<Game?> getMultiPlayerGame(Game game) async{
  var docs  = (await games.where("status", isEqualTo: 1).where("mode", isEqualTo: game.mode).where("difficulty", isEqualTo: game.difficulty).where("lastUpdate", isGreaterThan: DateTime.now().toUtc().millisecondsSinceEpoch - 3000).limit(1).get()).docs;
  if(docs.length == 0){
   return await _getNewGame(game);
  }
  else{
    return await _getExistingGame(docs);
  }
}

Future<Game?> getWithFriendGame(Game? game, int? gameId) async{
  if(game != null){
    return await _getNewGame(game);
  }
  else{
    List<QueryDocumentSnapshot<Object?>> docs;
    do{
    docs = (await games.where("gameId", isEqualTo: gameId).where("lastUpdate", isGreaterThan: DateTime.now().toUtc().millisecondsSinceEpoch - 3000).limit(1).get()).docs;
    if(docs.length == 0){
      await Future.delayed(Duration(seconds: 2,),);
    }}
    while(docs.length == 0 && FindingOpponentDialog.isActive);
    return _getExistingGame(docs);
  }
}

Future<Game> getGameById(String gameId) async{
  var result = (await games.doc(gameId).get()).data();
  return Game.fromMap(result as Map<String, dynamic>);
}

Future<String> postGame(Game game) async{
  return (await games.add(game.toMap())).id;
}

Future<Game?> _getNewGame(Game game) async{
  game.lastUpdate = DateTime.now().toUtc().millisecondsSinceEpoch;
String docId = await postGame(game);
    while(true && FindingOpponentDialog.isActive){
      await Future.delayed(Duration(seconds: 3,),);
      Game updatedGame = await getGameById(docId);
      if(updatedGame.status == 2){
        updatedGame.docId = docId;
        return updatedGame;
      }
      else{
        await updateGameField({"lastUpdate": DateTime.now().toUtc().millisecondsSinceEpoch}, docId);
      }
    }
    return null;
    
}

Future<Game> _getExistingGame(List<QueryDocumentSnapshot<Object?>> docs) async{

Game updatedGame = Game.fromMap(docs[0].data() as Map<String, dynamic>);
updatedGame.isInverted = true;
    updatedGame.firstPlayerName = PuzzleUser().name;
    updatedGame.firstPlayerTrophyCount = PuzzleUser().trophyCount;
    updatedGame.docId = docs[0].id;
    updatedGame.status = 2;
    await games.doc(docs[0].id).set(updatedGame.toMap());
    return updatedGame;
}

Future<void> updateGameField(Map<String, dynamic> newValues, String docId) async{
  await games.doc(docId).update(newValues);
}
}
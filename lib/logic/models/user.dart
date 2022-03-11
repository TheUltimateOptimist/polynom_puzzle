import 'package:firebase_auth/firebase_auth.dart';
import 'package:polynom_puzzle/logic/models/backEnd.dart';
import 'package:polynom_puzzle/logic/models/stats.dart';
import 'package:polynom_puzzle/presentation/lobby.dart';

class PuzzleUser {
  static final PuzzleUser _user = PuzzleUser._internal();
  FirebaseAuth _auth = FirebaseAuth.instance;

  User? user;
  int trophyCount = 2000;
  String name = "Guest";
  Stats stats = Stats();
  String singlePlayerDifficulty = Difficultie.linear;
   String multiPlayerDifficulty= Difficultie.linear;
   String withFriendDifficulty= Difficultie.linear;

  factory PuzzleUser() {
    return _user;
  }

  PuzzleUser._internal();

  Future<void> initialize() async {
    user = _auth.currentUser;
    if (user != null && !user!.isAnonymous) {
      await initializeUserData();}
  }

  Future<void> initializeUserData() async {
    var map = await BackEnd().getUser();
    trophyCount = map["trophyCount"];
    name = map["name"];
    stats = Stats.fromMap(map["stats"]);
    singlePlayerDifficulty = map["singlePlayerDifficulty"];
    multiPlayerDifficulty = map["multiPlayerDifficulty"];
    withFriendDifficulty = map["withFriendDifficulty"];
  }

  Future<void> setSinglePlayerDifficultie(String difficulty) async {
    singlePlayerDifficulty = difficulty;
    BackEnd().updateUserField("singlePlayerDifficulty", singlePlayerDifficulty);
  }

  Future<void> setMultiPlayerDifficultie(String difficulty) async {
    multiPlayerDifficulty = difficulty;
    BackEnd().updateUserField("multiPlayerDifficulty", multiPlayerDifficulty);
  }

  Future<void> setWithFriendDifficultie(String difficulty) async {
    withFriendDifficulty = difficulty;
    BackEnd().updateUserField("withFriendDifficulty", withFriendDifficulty);
  }

  Future<void> setTrophyCount(int newCount) async {
    trophyCount = newCount;
    BackEnd().updateUserField("trophyCount", trophyCount);
  }

  Map<String, dynamic> toMap() {
    return {
      "email": user!.email,
      "multiPlayerDifficulty": multiPlayerDifficulty,
      "singlePlayerDifficulty": singlePlayerDifficulty,
      "withFriendDifficulty": withFriendDifficulty,
      "name": name,
      "stats": stats.toMap(),
      "trophyCount": trophyCount,
    };
  }

  Future<void> login(String email, String password)async{
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      user = _auth.currentUser;
      await initializeUserData();
    }
    on FirebaseAuthException catch(e){
      print(e.message);
    }
  }

  Future<void> loginWithGoogle()async{
    
  }

  Future<void> logout()async{
    try{
      await _auth.signOut();
      user = _auth.currentUser;
    }
    on FirebaseAuthException catch(e){
      print(e.message);
    }
  }

  Future<void> register(String email, String userName, String password)async{
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      name = userName;
      user = _auth.currentUser;
      await BackEnd().addUser(this.toMap());
    }
    on FirebaseAuthException catch(e){
      print(e.message);
    }
  }

  Future<void> loginAsGuest() async{
    try{
      await _auth.signInAnonymously();
      user = _auth.currentUser;
    }
    on FirebaseAuthException catch(e){
      print(e.message);
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:polynom_puzzle/logic/models/backEnd.dart';
import 'package:polynom_puzzle/logic/models/stats.dart';
import 'package:flutter/foundation.dart';
import 'package:polynom_puzzle/presentation/lobby.dart';

class PuzzleUser {
  static final PuzzleUser _user = PuzzleUser._internal();
  FirebaseAuth _auth = FirebaseAuth.instance;

  User? user;
  int trophyCount = 2000;
  String name = "Guest";
  Stats stats = Stats();
  String singlePlayerDifficulty = Difficulty.linear;
  String multiPlayerDifficulty = Difficulty.linear;
  String withFriendDifficulty = Difficulty.linear;

  factory PuzzleUser() {
    return _user;
  }

  PuzzleUser._internal();

  Future<void> initialize() async {
    user = _auth.currentUser;
    if (user != null && !user!.isAnonymous) {
      await initializeUserData();
    }
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

  Future<String?> login(TextEditingController emailController,
      TextEditingController passwordController) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      user = _auth.currentUser;
      await initializeUserData();
      return null;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == "wrong-password") {
        passwordController.clear();
        return "Wrong password";
      }
      return e.message ?? "An error occurred";
    }
  }

  Future<String?> loginWithGoogle() async {
    late GoogleAuthProvider googleProvider;
    late final OAuthCredential credential;
    bool isWeb = false;
    if (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS) {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

     credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
    } else {
      isWeb = true;
      googleProvider = GoogleAuthProvider();

      googleProvider
          .addScope('https://www.googleapis.com/auth/contacts.readonly');
      googleProvider.setCustomParameters({'login_hint': 'user@example.com'});
    }
    try {
        UserCredential credentials =
            isWeb ? await _auth.signInWithPopup(googleProvider) : await _auth.signInWithCredential(credential);
            user = _auth.currentUser;
            if(user!.metadata.creationTime!.difference(user!.metadata.lastSignInTime!).inSeconds < 5){
              name = user!.displayName!;
              await BackEnd().addUser(this.toMap());
              return null;
            }
            await initializeUserData();
        return null;
      } on FirebaseAuthException catch (e) {
        return e.message;
      }
  }

  Future<String?> logout() async {
    try {
      await _auth.signOut();
      user = _auth.currentUser;
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message ?? "An error occurred";
    }
  }

  Future<String?> register(
      TextEditingController emailController,
      TextEditingController userNameController,
      TextEditingController passwordController) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      name = userNameController.text;
      user = _auth.currentUser;
      await BackEnd().addUser(this.toMap());
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        emailController.clear();
      }
      return e.message ?? "An error occurred";
    }
  }

  Future<String?> loginAsGuest() async {
    try {
      await _auth.signInAnonymously();
      user = _auth.currentUser;
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message ?? "An error occurred";
    }
  }
}


import 'package:polynom_puzzle/logic/models/user.dart';

class UserState{
  final PuzzleUser user;
  final String? errorMessage;
  UserState(this.user, {this.errorMessage});
}
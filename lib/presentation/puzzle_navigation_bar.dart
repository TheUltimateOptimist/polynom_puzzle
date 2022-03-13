import 'package:flutter/material.dart';
import 'package:polynom_puzzle/function_colors.dart';
import 'package:polynom_puzzle/presentation/lobby.dart';
import 'package:polynom_puzzle/presentation/profile.dart';
import 'package:polynom_puzzle/presentation/ranking.dart';

class PuzzleNavigationBar extends StatefulWidget {
  final int index;
  const PuzzleNavigationBar({Key? key, required this.index}) : super(key: key);

  static const double iconSize = 25;

  @override
  State<PuzzleNavigationBar> createState() => _PuzzleNavigationBarState();
}

class _PuzzleNavigationBarState extends State<PuzzleNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedIconTheme: IconThemeData(
        color: Colors.black,
      ),
      selectedIconTheme: IconThemeData(
        color: FunctionColors.one,
      ),
      selectedItemColor: FunctionColors.one,
      currentIndex: widget.index,
      onTap: (int selected) {
        if(selected != widget.index){
        if(selected == 0){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Profile()));}
        else if(selected == 1){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Lobby()));
        }
        else if(selected == 2){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Ranking(),));
        }}
      },
      iconSize: PuzzleNavigationBar.iconSize,
      backgroundColor: Colors.white,
      items: [
        BottomNavigationBarItem(
          label: "Profile",
          icon: Icon(
            Icons.boy_rounded,
          ),
        ),
        BottomNavigationBarItem(
          label: "Home",
          icon: Icon(
            Icons.home,
          ),
        ),
        BottomNavigationBarItem(
          label: "Ranking",
          icon: Icon(
            Icons.trending_up_rounded,
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:polynom_puzzle/presentation/Widgets/black_text.dart';
import 'package:polynom_puzzle/presentation/Widgets/coordinate_system/coordinate_system.dart';
import 'package:polynom_puzzle/presentation/Widgets/degree_select_button.dart';
import 'package:polynom_puzzle/presentation/Widgets/moves.dart';
import 'package:polynom_puzzle/presentation/Widgets/slide_puzzle.dart';

import 'Widgets/shuffle_button.dart';

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(margin: const EdgeInsets.only(left: 20, top: 15, bottom: 15, right: 15,),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        BlackText(
                          title: "PolynomPuzzle",
                          fontSize: 48,
                        ),
                        Moves(fontSize: 20,),
                      ],
                    ),
                    Row(
                      children: const [
                        DegreeSelectButton(degree: 1,),
                        DegreeSelectButton(degree: 2,),
                        DegreeSelectButton(degree: 3,),
                      ],
                    ),
                  ],
                ),
              const BlackText(title: "Change two tiles by selecting them", fontSize: 30, fontFamily: "Noteworthy-Light"),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: const [SlidePuzzle(), CoordinateSystem()/*const Visualization()*/],),
              Row(mainAxisAlignment: MainAxisAlignment.end,children: const [ShuffleButton()],)
            ],
          ),
        ),
      ),
    );
  }
}

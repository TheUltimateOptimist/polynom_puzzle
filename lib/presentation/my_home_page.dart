import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polynom_puzzle/logic/blocs/puzzle_cubit.dart';
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
    print(MediaQuery.of(context).size.width);
    return BlocBuilder<PuzzleCubit, PuzzleState>(
      builder: (context, state) {
        return LayoutBuilder(builder: (context, constraints) {
          late double puzzleHeight;
          late double systemHeight;
          if(constraints.maxWidth > 1210){
            puzzleHeight = 500;
            systemHeight = 600;
          }
          else if(constraints.maxWidth > 935){
            puzzleHeight = 400;
            systemHeight = 500;
          }
          else if(constraints.maxWidth > 780){
            puzzleHeight = 350;
            systemHeight = 400;
          }
          else{
            
          }
          double aroundMargin = (constraints.maxWidth - puzzleHeight - systemHeight - 10)/2;
          aroundMargin-=aroundMargin/6;

          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Container(
                margin: EdgeInsets.only(
                  left: aroundMargin,
                  top: 15,
                  bottom: 30,
                  right: aroundMargin,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            BlackText(
                              title: "PolynomPuzzle",
                              fontSize: 48,
                            ),
                            Moves(
                              fontSize: 20,
                            ),
                          ],
                        ),
                        Container(
                          width: 100,
                        ),
                        Row(
                          children: const [
                            DegreeSelectButton(
                              degree: 1,
                            ),
                            DegreeSelectButton(
                              degree: 2,
                            ),
                            DegreeSelectButton(
                              degree: 3,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const BlackText(
                        title: "Change two tiles by selecting them",
                        fontSize: 30,
                        fontFamily: "Noteworthy-Light"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SlidePuzzle(
                          cubit: context.read<PuzzleCubit>(),
                          height: puzzleHeight,
                          tileMargin: 10,
                        ),
                        Container(width: aroundMargin/3,),
                        CoordinateSystem(
                          height: systemHeight,
                        ) /*const Visualization()*/
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ShuffleButton(onPressed: () {
                          PuzzleCubit cubit = context.read<PuzzleCubit>();
                          cubit.shuffle();
                        })
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}

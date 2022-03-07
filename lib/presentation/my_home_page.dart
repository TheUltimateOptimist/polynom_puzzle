import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polynom_puzzle/constants/sizes.dart';
import 'package:polynom_puzzle/logic/blocs/puzzle_cubit.dart';
import 'package:polynom_puzzle/presentation/Widgets/coordinate_system/coordinate_system.dart';
import 'package:polynom_puzzle/presentation/Widgets/degree_select_button.dart';
import 'package:polynom_puzzle/presentation/Widgets/moves.dart';
import 'package:polynom_puzzle/presentation/Widgets/slide_puzzle.dart';
import 'package:polynom_puzzle/presentation/textStyles/black_text.dart';

import 'Widgets/shuffle_button.dart';

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PuzzleCubit, PuzzleState>(
      builder: (context, state) {
        return LayoutBuilder(builder: (context, constraints) {
          bool onMobile = false;
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
            onMobile = true;
            puzzleHeight = 180;
            systemHeight = 250;
            onMobile = true;
          }
          double aroundMargin = (constraints.maxWidth - puzzleHeight - systemHeight - 10)/2;
          aroundMargin-=aroundMargin/6;
          if(onMobile){
            aroundMargin = 5;
          }
          if(Sizes.setOnMobile(onMobile)){
            context.read<PuzzleCubit>().shuffle();
          }

          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Container(
                margin: EdgeInsets.only(
                  left: aroundMargin,
                  top: 15,
                  bottom: onMobile ? 10 : 30,
                  right: aroundMargin,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: onMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            BlackText(
                              text: "PolynomPuzzle",
                              fontSize: Sizes.titleSize(),
                            ),
                            Moves(
                              fontSize: Sizes.movesTextSize(),
                            ),
                          ],
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
                     BlackText(
                        text: "Match the red onto the black function!",
                        fontSize: Sizes.explanationTextSize(),
                        ),
                        !onMobile ?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SlidePuzzle(
                          cubit: context.read<PuzzleCubit>(),
                        ),
                        Container(width: aroundMargin/3,),
                        CoordinateSystem(
                          height: systemHeight,
                        ) /*const Visualization()*/
                      ],
                    ) : SlidePuzzle(
                          cubit: context.read<PuzzleCubit>(),
                        ),
                        onMobile? CoordinateSystem(
                          height: systemHeight,
                        ) : const Text(""),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polynom_puzzle/constants/sizes.dart';
import 'package:polynom_puzzle/function_colors.dart';
import 'package:polynom_puzzle/logic/blocs/puzzle_cubit.dart';
import 'package:polynom_puzzle/logic/models/function_part.dart';
import 'package:polynom_puzzle/logic/models/poly_part.dart';
import 'package:polynom_puzzle/logic/models/puzzle.dart';
import 'package:polynom_puzzle/presentation/Widgets/action_button.dart';
import 'package:polynom_puzzle/presentation/Widgets/dialog_text.dart';
import 'package:polynom_puzzle/presentation/Widgets/shuffle_button.dart';
import 'package:polynom_puzzle/presentation/Widgets/slide_tile.dart';

class SlidePuzzle extends StatefulWidget {
  final PuzzleCubit cubit;
  const SlidePuzzle({
    required this.cubit,
    Key? key,
  }) : super(key: key);

  static double tileHeight = 80;
  static double tileMargin = 10;
  static double puzzleHeight =
      Puzzle.coumnLength * tileHeight + (Puzzle.coumnLength - 1) * tileMargin;
  static double puzzleWidth =
      Puzzle.rowLength * tileHeight + (Puzzle.rowLength - 1) * tileMargin;
      static const int animationDuration = 300;

  @override
  State<SlidePuzzle> createState() => _SlidePuzzleState();
}

class _SlidePuzzleState extends State<SlidePuzzle> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PuzzleCubit, PuzzleState>(
      listener: (context, state) {
        if (state.puzzle.isSolved()) {
          showDialog(
            context: context,
            builder: (context) {
              return solvedDialog(context);
            },
          );
        }
      },
      builder: (context, state) {
        return Container(
          height: SlidePuzzle.puzzleHeight,
          width: SlidePuzzle.puzzleWidth,
          child: Stack(
            children: [
              for (FunctionPart part in state.puzzle.parts)
                AnimatedPositioned(
                  left: part.leftDistance,
                  top: part.topDistance,
                  duration: Duration(
                    milliseconds: SlidePuzzle.animationDuration,
                  ),
                  child: SlideTile(
                    content: ((part as PolyPart).scalar < 0 ? "-" : "+") + part.toString(),
                    color: calculateColor(part, state),
                    onPressed: (){
                      if(state.selectedPart != null){
                        context.read<PuzzleCubit>().changeTiles(part);
                      }
                      else{
                        context.read<PuzzleCubit>().selectFirst(part);
                      }
                    },
                    height: SlidePuzzle.tileHeight,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Color calculateColor(FunctionPart part, PuzzleState state){
    if(state.selectedPart != null && state.selectedPart!.id == part.id){
      return FunctionColors.two;
    }
    if(state.puzzle.isPartOfFunction(part)){
      return FunctionColors.one;
    }
    return FunctionColors.three;
  }

  solvedDialog(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal:
            Sizes.onMobile ? 40 : MediaQuery.of(context).size.width / 2 - 250,
        vertical:
            Sizes.onMobile ? 240 : MediaQuery.of(context).size.height / 2 - 250,
      ),
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.white,
      child: Container(
        margin: const EdgeInsets.only(
          top: 40,
          bottom: 10,
          left: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Congratulations!",
              style: TextStyle(
                color: FunctionColors.one,
                fontSize: 45,
                fontFamily: "Noteworthy-Bold",
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DialogText(
                  text: "You successfully matched the function",
                ),
                Container(
                  height: 20,
                ),
                const DialogText(
                  text: "You're now officially a math geak:)",
                ),
              ],
            ),
            Container(
              height: Sizes.onMobile ? 30 : 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ActionButton(
                  child: Text(
                    "Back",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Sizes.buttonTextSize(),
                        fontFamily: "Noteworthy-Light"),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                  width: Sizes.onMobile ? 5 : 10,
                ),
                ShuffleButton(
                  onPressed: () {
                    widget.cubit.shuffle();
                    Navigator.pop(context);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

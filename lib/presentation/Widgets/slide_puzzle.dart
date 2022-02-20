import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polynom_puzzle/function_colors.dart';
import 'package:polynom_puzzle/logic/blocs/puzzle_cubit.dart';
import 'package:polynom_puzzle/logic/models/function_part.dart';
import 'package:polynom_puzzle/presentation/Widgets/action_button.dart';
import 'package:polynom_puzzle/presentation/Widgets/dialog_text.dart';
import 'package:polynom_puzzle/presentation/Widgets/shuffle_button.dart';
import 'package:polynom_puzzle/presentation/Widgets/slide_tile.dart';

import 'function_name.dart';

class SlidePuzzle extends StatelessWidget {
  final PuzzleCubit cubit;
  final double height;
  final double tileMargin;
  const SlidePuzzle(
      {required this.cubit,
      Key? key,
      required this.height,
      required this.tileMargin})
      : super(key: key);

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
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(
                  left: 10,bottom: 4*tileMargin/3,
                ),
                child: FunctionName(
                    color: FunctionColors.one,
                    name: "f(x) = " +
                        state.puzzle.getCurrentFunction().toString())),
            SizedBox(
              width: height,
              height: height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (List<FunctionPart> partRow
                      in state.puzzle.asTwoDimList())
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (FunctionPart part in partRow)
                          SlideTile(
                            part: part,
                            height: height / 4 - tileMargin,
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  solvedDialog(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width / 2 - 250,
        vertical: MediaQuery.of(context).size.height / 2 - 250,
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
              "Congratulatios!",
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
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ActionButton(
                  child: const Text(
                    "Back",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: "Noteworthy-Light"),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                  width: 10,
                ),
                ShuffleButton(
                  onPressed: () {
                    cubit.shuffle();
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

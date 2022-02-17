import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polynom_puzzle/function_colors.dart';
import 'package:polynom_puzzle/logic/blocs/puzzle_cubit.dart';

class ShuffleButton extends StatelessWidget {
  final bool onFirstPage;
  const ShuffleButton({this.onFirstPage = true,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PuzzleCubit, PuzzleState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            PuzzleCubit cubit = context.read<PuzzleCubit>();
            cubit.shuffle();
            if(!onFirstPage){
              Navigator.pop(context);
            }
          },
          style: ElevatedButton.styleFrom(primary: FunctionColors.one),
          child: Row(
            children: const [
              Icon(Icons.replay_outlined, size: 25, color: Colors.white),
              Text(
                "Shuffle",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: "Noteworthy-Light"),
              )
            ],
          ),
        );
      },
    );
  }
}

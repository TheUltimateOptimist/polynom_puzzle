import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polynom_puzzle/function_colors.dart';
import 'package:polynom_puzzle/logic/blocs/puzzle_cubit.dart';
import 'package:polynom_puzzle/presentation/Widgets/action_button.dart';

class ShuffleButton extends StatelessWidget {
  final void Function() onPressed;
  const ShuffleButton({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.replay_outlined, size: 30, color: Colors.white),
          Container(
            margin: const EdgeInsets.only(
              bottom: 6,
              left: 3,
            ),
            child: const Text(
              "Shuffle",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: "Noteworthy-Light"),
            ),
          )
        ],
      ),
      onPressed: onPressed,
    );
  }
}

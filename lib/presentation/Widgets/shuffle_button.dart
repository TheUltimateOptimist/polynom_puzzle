import 'package:flutter/material.dart';
import 'package:polynom_puzzle/constants/sizes.dart';
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
           Icon(Icons.replay_outlined, size: Sizes.buttonTextSize(), color: Colors.white),
          Container(
            margin: const EdgeInsets.only(
              bottom: 6,
              left: 3,
            ),
            child: Text(
              "Shuffle",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Sizes.buttonTextSize(),
                  fontFamily: "Noteworthy-Light"),
            ),
          )
        ],
      ),
      onPressed: onPressed,
    );
  }
}

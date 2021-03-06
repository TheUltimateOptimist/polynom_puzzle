import 'package:flutter/material.dart';
import 'package:polynom_puzzle/constants/sizes.dart';
import 'package:polynom_puzzle/function_colors.dart';

class ActionButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;
  const ActionButton({required this.child, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: FunctionColors.one,
        fixedSize: Size(
          Sizes.onMobile ? Sizes.buttonHeight()*3.5 : 2.7*Sizes.buttonHeight(),
          Sizes.buttonHeight(),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
      ),
      child: child,
    );
  }
}
